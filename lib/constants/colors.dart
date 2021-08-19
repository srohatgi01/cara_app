import 'package:flutter/material.dart';

const primaryColor = 0xFF796AC8;
const backgroundColor = 0xFFF5F5F5;

Map<int, Color> color = {
  50: Color.fromRGBO(121, 106, 200, .1),
  100: Color.fromRGBO(121, 106, 200, .2),
  200: Color.fromRGBO(121, 106, 200, .3),
  300: Color.fromRGBO(121, 106, 200, .4),
  400: Color.fromRGBO(121, 106, 200, .5),
  500: Color.fromRGBO(121, 106, 200, .6),
  600: Color.fromRGBO(121, 106, 200, .7),
  700: Color.fromRGBO(121, 106, 200, .8),
  800: Color.fromRGBO(121, 106, 200, .9),
  900: Color.fromRGBO(121, 106, 200, 1),
};

MaterialColor customMaterialColor = MaterialColor(primaryColor, color);
