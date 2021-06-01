import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class FirebaseConections {
  static String idUser = "";

  static setUserId(userId) {
    idUser = userId;
  }

  static Stream<QuerySnapshot> getFuncionarios(filter) {
    var people_list;
    if (filter == "no-filter") {
      people_list = FirebaseFirestore.instance
          .collection("Funcionarios")
          .where(FieldPath.documentId, isNotEqualTo: idUser)
          .snapshots();
    } else {
      people_list = FirebaseFirestore.instance
          .collection("Funcionarios")
          .where('apelido', isEqualTo: filter)
          .where(FieldPath.documentId, isNotEqualTo: idUser)
          .snapshots();
    }
    return people_list;
  }

  static Stream<QuerySnapshot> getDepartamentos(filter) {
    var departament_list;
    if (filter == "no-filter") {
      departament_list =
          FirebaseFirestore.instance.collection("Departamentos").snapshots();
    } else {
      departament_list = FirebaseFirestore.instance
          .collection("Departamentos")
          .where('nome', isEqualTo: filter)
          .snapshots();
    }
    return departament_list;
  }

  static Stream<QuerySnapshot> getTimes(filter) {
    var times_list;
    times_list =
        FirebaseFirestore.instance.collection("Departamentos").snapshots();

    return times_list;
  }

  static Future uploadImageToFirebase(
      BuildContext context, String image_path, String image_name) async {
    String stored_image =
        "https://blog.e-inscricao.com/wp-content/uploads/2017/03/como-manter-a-organizacao-de-um-evento-enquanto-ele-e-realizado.jpeg";
    File image_file = File(image_path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('event_images/$image_name');
    UploadTask uploadTask = firebaseStorageRef.putFile(image_file);
    await uploadTask.whenComplete(() async {
      String url = (await firebaseStorageRef.getDownloadURL()).toString();
      stored_image = url;
    }).catchError((onError) {
      print(onError);
    });

    return stored_image;
  }
}
