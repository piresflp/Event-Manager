import 'package:Even7/pages/EventDetails/EventDetailsPage.dart';
import 'package:flutter/material.dart';

Widget TabConfirmados(TabController _tabController, List<Tab> myTabs) {
  return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          unselectedLabelColor: Color(0xFF0D1333),
          labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Color(0xFF0D1333),
          indicator: BoxDecoration(
            color: Colors.transparent,
            border:
                Border(bottom: BorderSide(color: Color(0xFF0D1333), width: 3)),
          ),
          tabs: myTabs,
        ),
      ),
      body: TabBarView(controller: _tabController, children: [
        Icon(Icons.directions_car),
        Icon(Icons.directions_transit),
      ]));
}
