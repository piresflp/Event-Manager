import 'package:cloud_firestore/cloud_firestore.dart';

class Api {
  static Future<dynamic> eventData(DocumentReference event) async {
    DocumentSnapshot eventRef = await event.get();
    return eventRef.data;
  }
}
