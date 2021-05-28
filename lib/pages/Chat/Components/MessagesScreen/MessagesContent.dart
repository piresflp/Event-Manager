import 'package:Even7/pages/Chat/Components/MessagesScreen/ChatInputField.dart';
import 'package:Even7/theme/colors.dart';
import 'package:Even7/utils/Api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ChatMessage.dart';

class MessagesContent extends StatefulWidget {
  final dynamic evento;
  final String idFunc;
  const MessagesContent({this.evento, required this.idFunc});

  @override
  _MessagesContentState createState() => _MessagesContentState();
}

class _MessagesContentState extends State<MessagesContent> {
  String apelido = "";

  getApelido() async {
    var documentSnapshot = await FirebaseFirestore.instance
        .collection('Funcionarios')
        .doc(widget.idFunc)
        .get();

    var funcData = documentSnapshot.data()!;
    var ape = funcData['apelido'];

    setState(() {
      apelido = ape;
    });
  }

  @override
  void initState() {
    super.initState();
    getApelido();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: generateMessages(widget.evento),
        )),
        ChatInputField(
            chat: widget.evento['chat'],
            idFunc: widget.idFunc,
            apelido: apelido),
      ],
    );
  }

  Widget generateMessages(evento) {
    return StreamBuilder(
        stream:
            evento['chat'].collection('messages').orderBy('date').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          var messages = snapshot.data!.docs;
          return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ChatMessage(
                    message: messages[index].data(),
                    idFunc: widget.idFunc,
                  ));
        });
  }
}

/*
return FutureBuilder(
      future: Api.eventData(evento['chat']),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        var chat = snapshot.data();

        return ListView.builder(
            itemCount: chat['messages'].length,
            itemBuilder: (context, index) =>
                ChatMessage(message: chat['messages'][index]));
      });
*/
