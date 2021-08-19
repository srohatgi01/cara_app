import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/constants/strings.dart';
import 'package:flutter/material.dart';

import 'widgets/google_sign_in.dart';

class GoogleAuthScreen extends StatelessWidget {
  const GoogleAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(backgroundColor),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              alignment: Alignment.center,
              child: Text(
                appName,
                style: TextStyle(
                    fontFamily: 'Signatra',
                    fontSize: 120,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            signUp(context: context),
          ],
        ));
  }

  Column signUp({required BuildContext context}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print('SignUp/SignIn Button was pressed.');
          },
          child: GoogleSignIn(),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('or'),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                print('Sign In later was pressed.');
              },
              child: Text(
                'Sign In later',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
