import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Content/AdmEventContent.dart';

Widget listYourEvents(idFunc) {
  return StreamBuilder(
      stream: getData(idFunc),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(
              child: Text("Parece que você não tem nenhum novo evento =("));
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            dynamic evento = snapshot.data!.docs[index].data()!;
            return AdmEventContent(
              numero: (index + 1),
              dia: evento["dia"],
              hora: evento["hora"],
              nome: evento["nome"],
            );
          }));
        }
      });
}

Stream<QuerySnapshot> getData(idFunc) {
  return FirebaseFirestore.instance
      .collection("Eventos")
      .where('idOrganizador', isEqualTo: idFunc)
      .snapshots();
}
