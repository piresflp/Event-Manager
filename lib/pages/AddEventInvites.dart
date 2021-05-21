import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class AddEventInvites extends StatefulWidget {
  @override
  _AddEventInvitesState createState() => _AddEventInvitesState();
}

class _AddEventInvitesState extends State<AddEventInvites> {
  var searchBar;
  String filter_list = "funcionarios";
  double distance_center_text = 0;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Procurar funcionarios'),
        actions: [searchBar.getSearchAction(context)]);
  }

  _AddEventInvitesState() {
    searchBar = SearchBar(
        inBar: false,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar);
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
              dynamic person = snapshot.data!.docs[index].data()!;
              bool? _isSelected = false;
              return CheckboxListTile(
                title: Container(
                    child: Row(
                  children: [
                    CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(person["foto"], scale: 0.4)),
                    SizedBox(width: distance_center_text),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(person["nome"]), Text(person["apelido"])],
                    )
                  ],
                )),
                value: _isSelected,
                onChanged: (bool? newValue) {
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
      body: Container(
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
          onPressed: () => null,
          child: Text(
            "Criar evento",
          ),
        ),
      )),
    );
  }
}
