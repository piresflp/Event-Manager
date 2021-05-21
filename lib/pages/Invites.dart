import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanager/theme/colors.dart';
import 'package:eventmanager/theme/styles.dart';
import 'package:eventmanager/utils/Api.dart';
import 'package:flutter/material.dart';

var idUser = 'JIL8fXU6qSO7ilMhyl6U0nbgvQk2';

var convites = [
  {
    "confirmado": false,
    "idEvento": "a2C2IoTogNGva4D8DLEO",
    "idFuncionario": "5obFGzkVj2HL0JlX4mlB"
  },
  {
    "confirmado": false,
    "idEvento": "a2C2IoTogNGva4D8DLEO",
    "idFuncionario": "5obFGzkVj2HL0JlX4mlB"
  },
  {
    "confirmado": false,
    "idEvento": "a2C2IoTogNGva4D8DLEO",
    "idFuncionario": "5obFGzkVj2HL0JlX4mlB"
  },
  {
    "confirmado": false,
    "idEvento": "a2C2IoTogNGva4D8DLEO",
    "idFuncionario": "5obFGzkVj2HL0JlX4mlB"
  }
];

class Invites extends StatefulWidget {
  @override
  _InvitesState createState() => _InvitesState();
}

class _InvitesState extends State<Invites> {
  void makeToast(var text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView(
          children: [
            Row(
              children: [
                Text("Convites",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        height: 1.3)),
              ],
            ),
            SizedBox(height: 30),
            listInvites(),
          ],
        ),
      ),
    );
  }

  Widget inviteItem(invite) {
    return FutureBuilder(
      future: Api.eventData(invite['eventoRef']),
      builder: (BuildContext context, AsyncSnapshot<dynamic> uData) {
        var evento = uData.data();

        return FutureBuilder(
            future: Api.eventData(evento['local']),
            builder: (BuildContext ctx, AsyncSnapshot<dynamic> localData) {
              var local = localData.data();

              return Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 50, 20),
                            child: Container(
                              child: Column(
                                children: [
                                  Text(evento['nome'], style: customTitle),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        evento['hora'],
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        evento['dia'],
                                        style:
                                            TextStyle(color: Colors.blueGrey),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
                                    child: Text(
                                      local['Descricao'],
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Container(
                                  width: 40,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Container(
                                  width: 40,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }

  Widget listInvites() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Convites")
            .where('idFuncionario', isEqualTo: 'JIL8fXU6qSO7ilMhyl6U0nbgvQk2')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Text("No data found"),
            );
          } else if (snapshot.data!.docs.length == 0) {
            return Container(
                child: Text("Parece que você não tem nenhum novo evento =("));
          } else {
            return Column(
                children: List.generate(snapshot.data!.docs.length, (index) {
              return inviteItem(snapshot.data!.docs[index].data());
            }));
          }
        });
  }
}
