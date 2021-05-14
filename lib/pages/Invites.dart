import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventmanager/theme/styles.dart';
import 'package:flutter/material.dart';

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

class Invites extends StatefulWidget {
  @override
  _InvitesState createState() => _InvitesState();
}

class _InvitesState extends State<Invites> {
  var _invites;

  void makeToast(var text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getInvites();
  }

  void getInvites() async {
    FirebaseFirestore.instance
        .collection("Convites")
        .where('idFuncionario', isEqualTo: idUser)
        .snapshots()
        .listen((data) => {print(data.docs)});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView(
          children: [
            Row(
              children: [
                Text("Convites",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        height: 1.3)),
              ],
            ),
            SizedBox(height: 30),
            Column(
              children: List.generate(convites.length, (index) {
                return inviteItem(convites[index]);
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget inviteItem(invite) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.all(60), child: Text(invite['idEvento']))
          ],
        ),
      ),
    );
  }
}
