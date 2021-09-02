import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/data/config/prefs.dart';
import 'package:cara_app/presentation/dashboard.dart';
import 'package:cara_app/presentation/authentication/google_auth_screen.dart';
import 'package:cara_app/providers/salon_provider.dart';
import 'package:cara_app/providers/search_provider.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var prefs = await Prefs.init();

  await prefs.initialCheck();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => SalonProvider()),
      ],
      child: CaraApp(),
    ),
    // ChangeNotifierProvider(
    //   create: (context) => UserProvider(),
    //   child: ChangeNotifierProvider(
    //     create: (context) => SearchProvider(),
    //     child: CaraApp(),
    //   ),
    // ),
  );
}

class CaraApp extends StatelessWidget {
  const CaraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      title: 'Cara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: customMaterialColor, fontFamily: 'Nexa'),
      home: userProvider.shouldShowAuth == false
          ? Dashboard()
          : GoogleAuthScreen(),
    );
  }
}

//TODO: heroku pg:psql postgresql-graceful-11268 --app postgres-cara-backend