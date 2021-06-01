import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Even7/utils/Api.dart';
import 'package:flutter/material.dart';
import '../Content/FuncionarioContent.dart';

Widget listConfirmados(idEvento, eventoRef) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Convites")
          .where('eventoRef', isEqualTo: eventoRef)
          .where('confirmado', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Container(child: Text("Nenhum convidado."));
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            dynamic convite = snapshot.data!.docs[index].data()!;
            return funcionarioItem(index, convite['idFuncionario']);
            //funcionarioItem(convite['funcionarioId']);
          }));
        }
      });
}

Widget funcionarioItem(int index, String idFuncionario) {
  return FutureBuilder(
      future: Api.getFuncionarioById(idFuncionario),
      builder: (BuildContext context, AsyncSnapshot<dynamic> uData) {
        if (!uData.hasData || uData.hasError) {
          return const Center(child: CircularProgressIndicator());
        }

        var funcionario = uData.data;
        return FuncionarioContent(numero: index + 1, nome: funcionario['nome']);
      });
}
