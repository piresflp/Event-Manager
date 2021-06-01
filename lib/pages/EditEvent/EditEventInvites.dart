import 'package:Even7/pages/EditEvent/Evento.dart';
import 'package:Even7/utils/Api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditEventInvites extends StatefulWidget {
  @override
  _EditEventInvitesState createState() => _EditEventInvitesState();

  Evento evento;
  EditEventInvites(this.evento);
}

class _EditEventInvitesState extends State<EditEventInvites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edite os convites")),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Convites')
                    .where('eventoRef', isEqualTo: widget.evento.eventoRef)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Container(child: Text("No data"));
                  else {
                    var convites = snapshot.data!.docs;
                    return SingleChildScrollView(
                      child: Column(
                          children: List.generate(convites.length,
                              (index) => generateInvite(convites[index]))),
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  saveChanges(context);
                },
                child: Text(
                  "Salvar alterações",
                  style: TextStyle(color: Colors.white),
                )),
            SizedBox(height: 50),
          ],
        ),
      )),
    );
  }

  Widget generateInvite(conviteRaw) {
    var convite = conviteRaw.data();

    return FutureBuilder(
        future: Api.getFunc(convite['idFuncionario']),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData)
            return Container(child: Text("no data"));
          else {
            var funcionario = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage("${funcionario['foto']}"),
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(width: 20),
                    Text(
                        "Status: ${convite['confirmado'] == true ? 'Confirmado' : 'Não confirmado'}"),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('Convites')
                              .doc(conviteRaw.id)
                              .delete();
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                    ),
                  ]),
            );
          }
        });
  }

  void saveChanges(context) async {
    var evento = widget.evento;
    FirebaseFirestore.instance.collection('Eventos').doc(evento.id).update({
      'dia': evento.dia,
      'hora': evento.hora,
      'local': evento.local,
      'nome': evento.nome,
      'tipo': evento.tipo
    });

    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
