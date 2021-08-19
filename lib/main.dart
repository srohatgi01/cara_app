import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/google_auth_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: customMaterialColor, fontFamily: 'Nexa'),
      home: GoogleAuthScreen(),
    );
  }
}
