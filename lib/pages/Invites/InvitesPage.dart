import 'package:Even7/theme/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Even7/theme/colors.dart';
import 'package:Even7/theme/styles.dart';
import 'package:Even7/utils/Api.dart';
import 'package:flutter/material.dart';

import 'ListInvites.dart';

var idUser = 'JIL8fXU6qSO7ilMhyl6U0nbgvQk2';

var convites = [
  {
    "confirmado": false,
    "idEvento": "a2C2IoTogNGva4D8DLEO",
    "idFuncionario": "5obFGzkVj2HL0JlX4mlB"
  },
  {
    "confirmado": false,
    "idEvento": "a2C2IoTogNGva4D8DLEO",
    "idFuncionario": "5obFGzkVj2HL0JlX4mlB"
  },
  {
    "confirmado": false,
    "idEvento": "a2C2IoTogNGva4D8DLEO",
    "idFuncionario": "5obFGzkVj2HL0JlX4mlB"
  },
  {
    "confirmado": false,
    "idEvento": "a2C2IoTogNGva4D8DLEO",
    "idFuncionario": "5obFGzkVj2HL0JlX4mlB"
  }
];

class InvitesPage extends StatefulWidget {
  @override
  _InvitesPageState createState() => _InvitesPageState();
}

class _InvitesPageState extends State<InvitesPage> {
  void makeToast(var text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.grey[200],
      width: double.infinity,
      child: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 25),
                  Text(
                    "Convites",
                    style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF0D1333),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ])),
        SizedBox(height: 20),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.white),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      listInvites(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    ));
  }
}
