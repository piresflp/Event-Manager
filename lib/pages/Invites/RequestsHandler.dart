import 'package:cloud_firestore/cloud_firestore.dart';

class RequestsHandler {
  static void acceptInvite(idInvite) {
    FirebaseFirestore.instance.collection('Convites').doc(idInvite).update({
      'confirmado': true,
    });
  }

  static void denyInvite(idInvite) {
    FirebaseFirestore.instance.collection('Convites').doc(idInvite).update({
      'confirmado': false,
    });
  }
}
