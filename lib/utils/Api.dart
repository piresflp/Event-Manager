import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static Future<dynamic> eventData(DocumentReference event) async {
    DocumentSnapshot eventRef = await event.get();
    return eventRef.data;
  }

  static Future getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("id");
  }
}
