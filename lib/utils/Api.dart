import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Even7/models/Event.dart';

class Api {
  static Future<dynamic> eventData(DocumentReference event) async {
    DocumentSnapshot eventRef = await event.get();
    return eventRef.data;
  }

  static Future<dynamic> getFuncionarioById(String idFuncionario) async {
    DocumentSnapshot funcionarioRef = await FirebaseFirestore.instance
        .collection("Funcionarios")
        .doc(idFuncionario)
        .get();
    return await funcionarioRef.data();
  }

  static Future getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("id");
  }

  static Future getEventoId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("idEvento");
  }

  static Future<dynamic> getFunc(String id) async {
    DocumentSnapshot funcionario = await FirebaseFirestore.instance
        .collection('Funcionarios')
        .doc(id)
        .get();

    return await funcionario.data();
  }
}
