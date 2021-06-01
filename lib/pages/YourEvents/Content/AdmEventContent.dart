import 'package:Even7/pages/EditEvent/EditEvent.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Even7/pages/EventDetails/EventDetailsPage.dart';
import 'package:Even7/models/Event.dart';

class AdmEventContent extends StatelessWidget {
  int number;
  Event event;

  AdmEventContent({
    Key? key,
    this.number = 0,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(number.toString(),
              style: TextStyle(
                fontSize: 32,
                color: Color(0xFF0D1333).withOpacity(.5),
                fontWeight: FontWeight.bold,
              )),
          SizedBox(width: 20),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: event.day + " - " + event.hour + "\n",
                style: TextStyle(
                    color: Color(0xFF0D1333).withOpacity(.5), fontSize: 18)),
            TextSpan(
                text: event.name,
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0D1333),
                    fontWeight: FontWeight.w600,
                    height: 1.5))
          ])),
          Spacer(),
          new GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EventDetailsPage(event)));
            },
            child: new Container(
              margin: EdgeInsets.only(left: 8),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF49CC96)),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            height: 40,
            width: 40,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Color(0xFF49CC96)),
            child: GestureDetector(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                preferences.setString("idEvento", this.event.id);
                Navigator.pushNamed(
                  context,
                  EditEvent.routeName,
                );
              },
              child: Icon(Icons.edit_outlined, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
