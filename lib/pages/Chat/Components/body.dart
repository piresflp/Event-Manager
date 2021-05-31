import 'package:Even7/pages/Chat/Components/FillOutButton.dart';
import 'package:Even7/pages/Chat/Components/MessagesScreen/MessagesScreen.dart';
import 'package:Even7/pages/Invites/InviteContent.dart';
import 'package:Even7/theme/colors.dart';
import 'package:Even7/utils/Api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ChatCard.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool adminEvents = false;
  String idFunc = '';

  Future getId() async {
    String id = await Api.getId();
    setState(() {
      idFunc = id;
    });
  }

  @override
  void initState() {
    super.initState();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.fromLTRB(
            kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
        color: Colors.lightBlue,
        child: Row(children: [
          FillOutlineButton(
            press: () {
              setState(() {
                adminEvents = false;
              });
            },
            text: "Eventos confirmados",
            isFilled: !adminEvents,
          ),
          SizedBox(width: kDefaultPadding),
          FillOutlineButton(
            press: () {
              setState(() {
                adminEvents = true;
              });
            },
            text: "Eventos administrados",
            isFilled: adminEvents,
          )
        ]),
      ),
      Expanded(child: adminEvents ? getAdminEvents() : getInviteChats()),
    ]);
  }

  Widget getInviteChats() {
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
                return ChatCard(
                    evento: evento,
                    chat: chat,
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessagesScreen(
                                chat: chat, evento: evento, idUser: idFunc))));
              });
        });
  }

  Widget getAdminEvents() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Eventos")
            .where('idOrganizador', isEqualTo: idFunc)
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
                    "Parece que você não administra nenhum novo evento =(",
                    style: TextStyle(color: Colors.black.withOpacity(0.3)),
                  )
                ],
              ),
            );
          } else {
            return Column(
                children: List.generate(snapshot.data!.docs.length, (index) {
              var evento = snapshot.data!.docs[index];
              return FutureBuilder(
                  future: Api.eventData(evento['chat']),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> rawChat) {
                    var chat = rawChat.data();
                    return ChatCard(
                        evento: evento,
                        chat: chat,
                        press: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MessagesScreen(
                                    chat: chat,
                                    evento: evento,
                                    idUser: idFunc))));
                  });
            }));
          }
        });
  }
}
