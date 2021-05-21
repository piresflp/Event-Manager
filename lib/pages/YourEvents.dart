import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:async/async.dart';
import 'package:rxdart/rxdart.dart';

class YourEvents extends StatefulWidget {
  @override
  _YourEventsState createState() => _YourEventsState();
}

class _YourEventsState extends State<YourEvents> {
  @override
  void initState() {
    super.initState();

    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                color: Colors.grey[200],
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 25),
                              Text(
                                "Seus Eventos",
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
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Organizados por você",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0xFF0D1333),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 20),
                                  listYourEvents(),
                                  SizedBox(height: 40),
                                  Text("Próximos eventos",
                                      style: TextStyle(
                                        fontSize: 22,
                                        color: Color(0xFF0D1333),
                                        fontWeight: FontWeight.bold,
                                      )),
                                  SizedBox(height: 20),
                                  listNextEvents(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ))));
  }
}

class EventContent extends StatelessWidget {
  final int numero;
  final String dia;
  final String hora;
  final String nome;

  const EventContent({
    Key? key,
    this.numero = 0,
    this.dia = "",
    this.hora = "",
    this.nome = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(numero.toString(),
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF0D1333).withOpacity(.5),
                fontWeight: FontWeight.bold,
              )),
          SizedBox(width: 20),
          Container(
            child: RichText(
                text: TextSpan(children: [
              TextSpan(
                  text: "$dia - $hora\n",
                  style: TextStyle(
                      color: Color(0xFF0D1333).withOpacity(.5), fontSize: 18)),
              TextSpan(
                  text: nome,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0D1333),
                      fontWeight: FontWeight.w600,
                      height: 1.5))
            ])),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 8),
            height: 40,
            width: 40,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFF49CC96)),
            child: Icon(Icons.search, color: Colors.white),
          )
        ],
      ),
    );
  }
}

class AdmEventContent extends StatelessWidget {
  final int numero;
  final String dia;
  final String hora;
  final String nome;

  const AdmEventContent({
    Key? key,
    this.numero = 0,
    this.dia = "",
    this.hora = "",
    this.nome = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(numero.toString(),
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF0D1333).withOpacity(.5),
                fontWeight: FontWeight.bold,
              )),
          SizedBox(width: 20),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: "$dia - $hora\n",
                style: TextStyle(
                    color: Color(0xFF0D1333).withOpacity(.5), fontSize: 18)),
            TextSpan(
                text: nome,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0D1333),
                    fontWeight: FontWeight.w600,
                    height: 1.5))
          ])),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 10),
            height: 40,
            width: 40,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFF49CC96)),
            child: Icon(Icons.search, color: Colors.white),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            height: 40,
            width: 40,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFF49CC96)),
            child: Icon(Icons.edit_outlined, color: Colors.white),
          )
        ],
      ),
    );
  }
}

Widget listYourEvents() {
  String idUser = "JIL8fXU6qSO7ilMhyl6U0nbgvQk2"; // TODO: Pegar idUser
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Eventos")
          .where('idOrganizador', isEqualTo: idUser)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return RichText(
            text: TextSpan(children: [
              TextSpan(
                  text:
                      "Opa! Parece que você ainda não organiza nenhum evento :(")
            ]),
          );
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            dynamic evento = snapshot.data!.docs[index].data()!;
            return AdmEventContent(
              numero: (index + 1),
              dia: evento["dia"],
              hora: evento["hora"],
              nome: evento["nome"],
            );
          }));
        }
      });
}

Stream<QuerySnapshot> getData() {
  var stream1 = FirebaseFirestore.instance
      .collection("Eventos")
      .where('idOrganizador', isEqualTo: "JIL8fXU6qSO7ilMhyl6U0nbgvQk2")
      .snapshots();
  var stream2 = FirebaseFirestore.instance
      .collection("Convites")
      .where('idFuncionario', isEqualTo: 'JIL8fXU6qSO7ilMhyl6U0nbgvQk2')
      .where('confirmado', isEqualTo: 'True')
      .snapshots();
  return stream1.mergeWith([stream2]);
}

Widget listNextEvents() {
  String idUser = "JIL8fXU6qSO7ilMhyl6U0nbgvQk2"; // TODO: Pegar idUser
  return StreamBuilder(
      stream: getData(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return RichText(
            text: TextSpan(
                children: [TextSpan(text: "Nenhum evento por enquanto.")]),
          );
        } else {
          return Column(
              children: List.generate(snapshot.data!.docs.length, (index) {
            dynamic evento = snapshot.data!.docs[index].data()!;
            return EventContent(
              numero: (index + 1),
              dia: evento["dia"],
              hora: evento["hora"],
              nome: evento["nome"],
            );
          }));
        }
      });
}
