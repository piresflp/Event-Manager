import 'package:Even7/theme/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController txtController = TextEditingController();
  final DocumentReference chat;
  final String idFunc;
  final String apelido;

  ChatInputField(
      {Key? key,
      required this.chat,
      required this.idFunc,
      required this.apelido})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08))
      ]),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.mic, color: Colors.lightBlue),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: kDefaultPadding * 0.75),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(Icons.sentiment_satisfied_alt_outlined,
                        color: Colors.black54),
                    SizedBox(width: kDefaultPadding),
                    Expanded(
                      child: TextField(
                        controller: txtController,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {
                          sendMessage(value);
                          txtController.clear();
                        },
                        decoration: InputDecoration(
                            hintText: "Digite uma mensagem",
                            border: InputBorder.none),
                      ),
                    ),
                    Icon(Icons.attach_file, color: Colors.black54),
                    SizedBox(width: kDefaultPadding / 4),
                    Icon(Icons.camera_alt_outlined, color: Colors.black54),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendMessage(text) {
    Map<String, dynamic> msgObject = {
      'date': DateTime.now(),
      'idSender': idFunc,
      'sender': apelido,
      'text': text,
    };

    chat.collection('messages').add(msgObject);
    chat.update({
      'lastMessage': msgObject,
    });
  }
}
