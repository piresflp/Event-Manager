import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../Content/FuncionarioContent.dart';

Widget listConvidados(idFunc) {
  return StreamBuilder(
      stream: getData(idFunc),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(child: Text("Nenhum convidado."));
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            dynamic evento = snapshot.data!.docs[index].data()!;
            return FuncionarioContent(
              numero: (index + 1),
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
