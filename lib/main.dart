import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/data/config/prefs.dart';
import 'package:cara_app/presentation/dashboard.dart';
import 'package:cara_app/presentation/google_auth_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  bool? shouldShowAuth = false;

  var prefs = await Prefs.init();

  shouldShowAuth = await prefs.authScreenStatus();
  await prefs.isSignedIn();

  runApp(MaterialApp(
    title: 'Cara',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: customMaterialColor, fontFamily: 'Nexa'),
    home: shouldShowAuth == false ? Dashboard() : GoogleAuthScreen(),
  ));
}
