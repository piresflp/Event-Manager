import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class Evento {
  final String nome;
  final String dia;
  final String hora;
  final String local;
  final String tipo;
  final String idOrganizador;

  const Evento({
    this.nome = "",
    this.dia = "",
    this.hora = "",
    this.local = "",
    this.tipo = "",
    this.idOrganizador = "",
  });
}

class AddEventInvites extends StatefulWidget {
  final Evento data;

  AddEventInvites({required this.data});

  @override
  _AddEventInvitesState createState() => _AddEventInvitesState(data);
}

class _AddEventInvitesState extends State<AddEventInvites> {
  var searchBar;
  String filter_list = "funcionarios";
  double distance_center_text = 0;

  Evento new_event;
  List<String> invitedUsers = <String>[];

  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  _AddEventInvitesState(this.new_event) {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
  }

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Procurar funcionarios'),
        actions: [searchBar.getSearchAction(context)]);
  }

  Stream<QuerySnapshot> getFuncionarios() {
    var people_list;
    people_list =
        FirebaseFirestore.instance.collection("Funcionarios").snapshots();
    return people_list;
  }

  Widget list(String filter) {
    return StreamBuilder(
        stream: getFuncionarios(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return RichText(
              text: TextSpan(
                  children: [TextSpan(text: "Nenhuma pessoa disponível.")]),
            );
          } else {
            return Column(
                children: List.generate(snapshot.data!.docs.length, (index) {
              dynamic person = snapshot.data!.docs[index];
              bool? _isSelected = false;
              return CheckboxListTile(
                title: Container(
                    child: Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(person.data()!["foto"], scale: 0.4)),
                    SizedBox(width: distance_center_text),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(person.data()!["nome"]),
                        Text(person.data()!["apelido"])
                      ],
                    )
                  ],
                )),
                value: _isSelected,
                onChanged: (bool? newValue) {
                  invitedUsers.add(person.id);
                  debugPrint("oi");
                  setState(() {
                    _isSelected = newValue;
                  });
                },
              );
            }));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    distance_center_text = MediaQuery.of(context).size.height * 3 / 100;

    return new Scaffold(
      appBar: searchBar.build(context),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: [
              InputChip(
                onPressed: () => filter_list = "funcionarios",
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: const Icon(Icons.person),
                ),
                label: const Text('Funcionários'),
              ),
              InputChip(
                onPressed: () => filter_list = "times",
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: const Icon(Icons.people),
                ),
                label: const Text('Times'),
              ),
              InputChip(
                onPressed: () => filter_list = "departamentos",
                avatar: CircleAvatar(
                  backgroundColor: Colors.grey.shade800,
                  child: const Icon(Icons.groups),
                ),
                label: const Text('Depertamentos'),
              ),
            ],
          ),
          Center(
            child: Column(
              children: <Widget>[list(filter_list)],
            ),
          ),
        ],
      )),
      bottomNavigationBar: Container(
          child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(double.infinity, 55)),
        child: ElevatedButton(
          onPressed: () {
            String event_id = getRandomString(20);
            FirebaseFirestore.instance.collection("Eventos").doc(event_id).set({
              "nome": new_event.nome,
              "dia": new_event.dia,
              "hora": new_event.hora,
              "idOrganizador": new_event.idOrganizador,
              "local": new_event.local,
              "tipo": new_event.tipo
            });
            DocumentReference docRef =
                FirebaseFirestore.instance.collection("Eventos").doc(event_id);
            for (int i = 0; i < invitedUsers.length; i++) {
              FirebaseFirestore.instance.collection("Convites").doc().set({
                "confirmado": null,
                "eventoRef": docRef,
                "idFuncionario": invitedUsers[i]
              });
            }
          },
          child: Text(
            "Criar evento",
          ),
        ),
      )),
    );
  }
}
