import 'package:Even7/pages/Chat/Components/ChatInputField.dart';
import 'package:Even7/theme/colors.dart';
import 'package:flutter/material.dart';

var idFunc = 'JIL8fXU6qSO7ilMhyl6U0nbgvQk2';

class MessagesContent extends StatefulWidget {
  final dynamic chat;
  MessagesContent({this.chat});

  @override
  _MessagesContentState createState() => _MessagesContentState();
}

class _MessagesContentState extends State<MessagesContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: ListView.builder(
            itemCount: widget.chat['messages'].length,
            itemBuilder: (context, index) =>
                ChatMessage(message: widget.chat['messages'][index]),
          ),
        )),
        ChatInputField(),
      ],
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final dynamic message;

  @override
  Widget build(BuildContext context) {
    final isSender = message['idSender'] == idFunc;

    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) ...[
            CircleAvatar(
              radius: 14,
              backgroundImage: NetworkImage(
                  'https://ogimg.infoglobo.com.br/in/25029405-e18-6f7/FT1086A/xNeymar.jpg.pagespeed.ic.cAdoMyEbH3.jpg'),
            ),
            SizedBox(width: kDefaultPadding / 2),
          ],
          MessageText(isSender: isSender, message: message)
        ],
      ),
    );
  }
}

class MessageText extends StatelessWidget {
  const MessageText({
    Key? key,
    required this.isSender,
    required this.message,
  }) : super(key: key);

  final bool isSender;
  final dynamic message;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding / 2),
        decoration: BoxDecoration(
            color: Colors.lightBlue.withOpacity(isSender ? 1 : 0.1),
            borderRadius: BorderRadius.circular(30)),
        child: Text(message['text'], style: TextStyle(color: Colors.white)));
  }
}
