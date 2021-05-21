import 'package:Even7/pages/Chat/Components/FillOutButton.dart';
import 'package:Even7/pages/Invites/InviteContent.dart';
import 'package:Even7/pages/Invites/RequestsHandler.dart';
import 'package:Even7/theme/colors.dart';
import 'package:Even7/utils/Api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

var idFunc = 'JIL8fXU6qSO7ilMhyl6U0nbgvQk2';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.fromLTRB(
            kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
        color: Colors.lightBlue,
        child: Row(children: [
          FillOutlineButton(press: () {}, text: "Eventos confirmados"),
          SizedBox(width: kDefaultPadding),
          FillOutlineButton(
            press: () {},
            text: "Eventos administrados",
            isFilled: false,
          )
        ]),
      ),
      Expanded(child: getChats()),
    ]);
  }
}

Widget getChats() {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Convites')
          .where('idFuncionario', isEqualTo: idFunc)
          .where('confirmado', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Container(
            child: Text("No data found"),
          );
        else if (snapshot.data!.docs.length == 0) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.mark_email_read_outlined,
                  size: 150,
                  color: Colors.black.withOpacity(0.3),
                ),
                Text(
                  "Parece que você não tem nenhum novo evento =(",
                  style: TextStyle(color: Colors.black.withOpacity(0.3)),
                )
              ],
            ),
          );
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            return chatItem(snapshot.data!.docs[index], index);
          }));
        }
      });
}

Widget chatItem(rawInvite, index) {
  final id = rawInvite.id;
  final invite = rawInvite.data();

  return FutureBuilder(
      future: Api.eventData(invite['eventoRef']),
      builder: (BuildContext context, AsyncSnapshot<dynamic> uData) {
        var evento = uData.data();
        return FutureBuilder(
            future: Api.eventData(evento['chat']),
            builder: (BuildContext context, AsyncSnapshot<dynamic> rawChat) {
              var chat = rawChat.data();

              return ChatCard(evento: evento, chat: chat);
            });
      });
}

class ChatCard extends StatelessWidget {
  final dynamic evento;
  final dynamic chat;

  const ChatCard({
    Key? key,
    this.evento,
    this.chat,
  }) : super(key: key);

  String convertTimestamp(timestamp) {
    if (timestamp == null) return "";

    var parsed = DateTime.parse(timestamp.toDate().toString());
    String ret = parsed.hour.toString() + ":" + parsed.minute.toString();
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
      child: Row(children: [
        CircleAvatar(
            radius: 24, backgroundImage: NetworkImage(evento['imagem'])),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                evento['nome'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Opacity(
                opacity: 0.64,
                child: Text(
                  chat['lastMessage']['message'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        )),
        Opacity(
            opacity: 0.64,
            child: Text(convertTimestamp(chat['lastMessage']['date']))),
      ]),
    );
  }
}
