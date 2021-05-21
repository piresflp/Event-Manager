import 'package:Even7/pages/Invites/RequestsHandler.dart';
import 'package:Even7/utils/Api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'InviteContent.dart';

Widget listInvites() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Convites")
          .where('idFuncionario', isEqualTo: 'JIL8fXU6qSO7ilMhyl6U0nbgvQk2')
          .where('confirmado', isNull: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            child: Text("No data found"),
          );
        } else if (snapshot.data!.docs.length == 0) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mark_email_read_outlined,
                  size: 150,
                  color: Colors.black.withOpacity(0.3),
                ),
                Text(
                  "Parece que você não tem nenhum novo evento =(",
                  style: TextStyle(color: Colors.black.withOpacity(0.3)),
                )
              ],
            ),
          );
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            return inviteItem(snapshot.data!.docs[index], index);
          }));
        }
      });
}

Widget inviteItem(rawInvite, index) {
  final id = rawInvite.id;
  final invite = rawInvite.data();

  return FutureBuilder(
    future: Api.eventData(invite['eventoRef']),
    builder: (BuildContext context, AsyncSnapshot<dynamic> uData) {
      var evento = uData.data();

      return InviteContent(
        id: id,
        dia: evento['dia'],
        hora: evento['hora'],
        nome: evento['nome'],
        numero: (index + 1),
        acceptInvite: RequestsHandler.acceptInvite,
        denyInvite: RequestsHandler.denyInvite,
      );
    },
  );
}
