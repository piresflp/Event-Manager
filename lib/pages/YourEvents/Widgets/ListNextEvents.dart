import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import '../Content/EventContent.dart';

Widget listNextEvents() {
  return StreamBuilder(
      stream: getData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(
              child: Text("Parece que você não tem nenhum novo evento =("));
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            dynamic evento = snapshot.data!.docs[index].data()!;
            return EventContent(
              numero: (index + 1),
              dia: evento["dia"],
              hora: evento["hora"],
              nome: evento["nome"],
            );
          }));
        }
      });
}

Stream<QuerySnapshot> getData() {
  var stream1 = FirebaseFirestore.instance
      .collection("Eventos")
      .where('idOrganizador', isEqualTo: "JIL8fXU6qSO7ilMhyl6U0nbgvQk2")
      .snapshots();
  var stream2 = FirebaseFirestore.instance
      .collection("Convites")
      .where('idFuncionario', isEqualTo: "JIL8fXU6qSO7ilMhyl6U0nbgvQk2")
      .where('confirmado', isEqualTo: 'True')
      .snapshots();
  return stream1.mergeWith([stream2]);
}
