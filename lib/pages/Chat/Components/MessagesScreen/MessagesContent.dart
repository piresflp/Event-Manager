import 'package:Even7/pages/Chat/Components/MessagesScreen/ChatInputField.dart';
import 'package:Even7/theme/colors.dart';
import 'package:flutter/material.dart';

import 'ChatMessage.dart';

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
