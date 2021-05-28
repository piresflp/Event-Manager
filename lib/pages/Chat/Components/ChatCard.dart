import 'package:Even7/theme/colors.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  final dynamic evento;
  final dynamic chat;
  final VoidCallback press;

  const ChatCard({
    Key? key,
    required this.evento,
    required this.chat,
    required this.press,
  }) : super(key: key);

  String convertTimestamp(timestamp) {
    if (timestamp == null) return "";

    var parsed = DateTime.parse(timestamp.toDate().toString());
    String ret = parsed.hour.toString() + ":" + parsed.minute.toString();
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
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
                    chat['lastMessage']['text'],
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
      ),
    );
  }
}
