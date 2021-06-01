import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Even7/models/Event.dart';
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
            dynamic data = snapshot.data!.docs[index].data()!;

            Event eventModel = Event(
                snapshot.data!.docs[index].id,
                data['nome'],
                data['nomeOrg'],
                data['dia'],
                data['hora'],
                data['local'],
                data['tipo']);

            return AdmEventContent(
                number: index + 1,
                event: eventModel,
                reference: data['eventRef']);
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
