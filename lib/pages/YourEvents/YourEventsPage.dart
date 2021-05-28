import 'package:Even7/utils/Api.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Widgets/ListYourEvents.dart';
import 'Widgets/ListNextEvents.dart';

class YourEvents extends StatefulWidget {
  @override
  _YourEventsState createState() => _YourEventsState();
}

class _YourEventsState extends State<YourEvents> {
  String idUser = "";

  Future getId() async {
    String id = await Api.getId();
    setState(() {
      idUser = id;
    });
  }

  @override
  initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    getId();
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
                        child: LayoutBuilder(builder: (context, constraint) {
                          return SingleChildScrollView(
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
                                    listYourEvents(idUser),
                                    SizedBox(height: 40),
                                    Text("Próximos eventos",
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Color(0xFF0D1333),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    SizedBox(height: 20),
                                    listNextEvents(idUser),
                                  ],
                                ),
                              ),
                            ],
                          ));
                        }),
                      ),
                    )
                  ],
                ))));
  }
}
