import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Even7/utils/Api.dart';
import 'package:Even7/models/Event.dart';
import '../Content/EventContent.dart';

Widget listNextEvents(idFunc) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Convites")
          .where('idFuncionario', isEqualTo: idFunc)
          .where('confirmado', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData) {
          return Container(
              child: Text("Parece que você não tem nenhum novo evento =("));
        } else if (snapshot.data!.docs.length == 0) {
          return Container(
              child: Text("Parece que você não tem nenhum novo evento =("));
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            return eventItem(snapshot.data!.docs[index].id,
                snapshot.data!.docs[index].data(), index);
          }));
        }
      });
}

Widget eventItem(id, event, index) {
  return FutureBuilder(
    future: Api.eventData(event['eventoRef']),
    builder: (BuildContext context, AsyncSnapshot<dynamic> uData) {
      if (!uData.hasData || uData.hasError) {
        return const Center(child: CircularProgressIndicator());
      }

      var data = uData.data();
      Event eventModel = Event(
          event['eventoRef'].id,
          data['nome'],
          data['nomeOrg'],
          data['dia'],
          data['hora'],
          data['local'],
          data['tipo']);

      return EventContent(number: index + 1, event: eventModel);
    },
  );
}
