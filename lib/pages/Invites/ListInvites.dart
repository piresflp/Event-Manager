import 'package:Even7/utils/Api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'InviteContent.dart';

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
            return inviteItem(snapshot.data!.docs[index].data(), index);
          }));
        }
      });
}

Widget inviteItem(invite, index) {
  return FutureBuilder(
    future: Api.eventData(invite['eventoRef']),
    builder: (BuildContext context, AsyncSnapshot<dynamic> uData) {
      var evento = uData.data();

      return FutureBuilder(
          future: Api.eventData(evento['local']),
          builder: (BuildContext ctx, AsyncSnapshot<dynamic> localData) {
            var local = localData.data();
            return InviteContent(
                dia: evento['dia'],
                hora: evento['hora'],
                nome: evento['nome'],
                numero: index + 1);
          });
    },
  );
}
