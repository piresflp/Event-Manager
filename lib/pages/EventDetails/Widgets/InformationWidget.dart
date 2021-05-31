import 'package:flutter/material.dart';

Widget informationWidget(String type, String data) {
  return Row(
    children: [
      Text(type + ": ",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFF0D1333),
            fontWeight: FontWeight.bold,
          )),
      Flexible(
        child: Text(
          data,
          style: TextStyle(fontSize: 18, color: Color(0xFF0D1333)),
        ),
      ),
      SizedBox(height: 20),
    ],
  );
}
