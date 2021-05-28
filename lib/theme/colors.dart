import 'package:flutter/material.dart';

var primary = Color(0xFF00954d);
var white = Color(0xFFFFFFFF);
var bgColor = Color(0xFFf0f1f3);
var black = Color(0xFF000000);
var textFieldColor = Colors.grey.withOpacity(0.15);
var yellowStar = Color(0xFFfacb00);
var blackTheme = Color(0x121212);
var cyan = fromHex('#30b6d1');
var almostWhite = fromHex('#f0f0f0');

const kPrimaryColor = Color(0xFF00BF6D);
const kSecondaryColor = Color(0xFFFE9901);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

Color fromHex(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}
