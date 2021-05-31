import 'package:Even7/pages/YourEvents/Widgets/ListYourEvents.dart';
import 'package:Even7/utils/Api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Even7/pages/YourEvents/Widgets/ListNextEvents.dart';
import 'package:flutter/material.dart';

class EventDetailsPage extends StatefulWidget {
  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String idUser = "";

  Future getId() async {
    String id = await Api.getId();
    setState(() {
      idUser = id;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: myTabs.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });
    getId();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp().whenComplete(() {
      setState(() {});
    });
    return Material(
      child: SafeArea(
          child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: Column(children: <Widget>[
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
                  child: Scaffold(
                      body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            child: TabBar(
                          tabs: myTabs,
                          labelStyle: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                          unselectedLabelColor: const Color(0xffacb3bf),
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 3.0,
                          indicatorPadding: EdgeInsets.all(10),
                          isScrollable: false,
                          controller: _tabController,
                        )),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  listYourEvents(idUser),
                                  listNextEvents(idUser)
                                ]),
                          ),
                        )
                      ],
                    ),
                  )),
                ))
              ]))),
    );
  }
}

final List<Tab> myTabs = <Tab>[
  Tab(
    text: "Convidados",
  ),
  Tab(
    text: "Confirmados",
  )
];
