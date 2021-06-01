import 'Widgets/ListConvidados.dart';
import 'Widgets/ListConfirmados.dart';
import 'package:Even7/utils/Api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Widgets/InformationWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Even7/models/Event.dart';

class EventDetailsPage extends StatefulWidget {
  final Event event;

  EventDetailsPage(this.event);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String idUser = "";
  dynamic eventoRef;

  Future getId() async {
    String id = await Api.getId();

    await getEvent(widget.event.id);
    debugPrint(widget.event.id);
    setState(() {
      idUser = id;
    });
  }

  Future getEvent(idEvento) async {
    var eventoRefe =
        await FirebaseFirestore.instance.collection("Eventos").doc(idEvento);

    var eventoF = await eventoRefe.get();
    setState(() {
      eventoRef = eventoRefe;
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
                            widget.event.name == null ? '' : widget.event.name,
                            style: TextStyle(
                              fontSize: 26,
                              color: Color(0xFF0D1333),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              widget.event.day +
                                  " - " +
                                  widget.event.hour +
                                  "\n",
                              style: TextStyle(
                                  color: Color(0xFF0D1333).withOpacity(.75),
                                  fontSize: 20)),
                        ])),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      informationWidget("Organizador", widget.event.orgName),
                      SizedBox(height: 20),
                      informationWidget("Local", widget.event.local),
                      SizedBox(height: 20),
                      informationWidget("Tipo de evento", widget.event.type),
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
                                  listConvidados(widget.event.id, eventoRef),
                                  listConfirmados(widget.event.id, eventoRef)
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
