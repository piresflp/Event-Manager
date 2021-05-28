import 'package:Even7/pages/YourEvents/Content/EventContent.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 25),
                    Text(
                      "Título Evento",
                      style: TextStyle(
                        fontSize: 26,
                        color: Color(0xFF0D1333),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Data Evento",
                        style: TextStyle(
                            color: Color(0xFF0D1333).withOpacity(.75),
                            fontSize: 20)),
                  ])),
          Padding(
            padding: EdgeInsets.only(right: 180, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Organizador: ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0D1333),
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20),
                Text("Local: ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0D1333),
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20),
                Text("Tipo de evento: ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF0D1333),
                      fontWeight: FontWeight.bold,
                    )),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[],
                )),
          ),
        ],
      ),
    )));
  }
}

final List<Tab> myTabs = <Tab>[
  Tab(
    text: "1",
  ),
  Tab(text: "2")
];
