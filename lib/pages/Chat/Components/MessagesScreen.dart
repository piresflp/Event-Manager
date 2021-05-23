import 'package:Even7/pages/Chat/Components/MessagesContent.dart';
import 'package:Even7/theme/colors.dart';
import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  final dynamic chat;
  final dynamic evento;

  MessagesScreen({this.chat, this.evento});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String getLastActivity(timestamp) {
    if (timestamp == null) return "";

    DateTime now = DateTime.now();
    var parsed = DateTime.parse(timestamp.toDate().toString());

    Duration difference = now.difference(parsed);
    int minutes = difference.inMinutes;
    return "Ativo há $minutes minutos";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: MessagesContent(chat: widget.chat),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(backgroundImage: NetworkImage(widget.evento['imagem'])),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.evento['nome'],
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                getLastActivity(widget.chat['lastMessage']['date']),
                style: TextStyle(fontSize: 12, color: Colors.white70),
              ),
            ],
          )
        ],
      ),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.group))],
    );
  }
}
