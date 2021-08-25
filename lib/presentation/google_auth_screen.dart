import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/constants/strings.dart';
import 'package:cara_app/data/config/prefs.dart';
import 'package:cara_app/data/models/carauser.dart';
import 'package:cara_app/data/models/guser.dart';
import 'package:cara_app/data/provider/auth/auth.dart';
import 'package:cara_app/data/repositories/user_repo.dart';
import 'package:cara_app/presentation/dashboard.dart';
import 'package:cara_app/presentation/get_phone_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/google_sign_in.dart';

class GoogleAuthScreen extends StatelessWidget {
  const GoogleAuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topRight,
              child: Image.asset(
                'assets/upper_leaf.png',
                height: 200,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'assets/lower_leaf.png',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      appName,
                      style: TextStyle(
                          fontFamily: 'Signatra',
                          fontSize: 120,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Expanded(child: signUp(context: context)),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          'assets/hair_girl.png',
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/pole_man.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column signUp({required BuildContext context}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            print('SignUp/SignIn Button was pressed.');
            dynamic response = await UserRepository().authenticate();

            if (response is CaraUser) {
              print(
                  'Cara User ${response.firstName} ${response.lastName} Returned');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Provider<CaraUser>(
                      create: (context) => response,
                      child: Dashboard(),
                    ),
                  ));
            } else if (response is GUser) {
              print('User not found \n Navigating to get phoneNumber');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Provider<GUser>(
                      create: (context) => response,
                      child: GetPhoneNumberScreen(),
                    ),
                  ));
            }

            // var prefs = await Prefs.init();
            // prefs.signInUser();
            // prefs.dontShowAuthScreen();
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => Dashboard()));
          },
          child: GoogleSignIn(),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'or',
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () async {
                print('Sign In later was pressed.');

                var prefs = await Prefs.init();
                prefs.dontShowAuthScreen();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Dashboard()));
              },
              child: Text(
                'Sign In later',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
            ),
          ],
        )
      ],
    );
  }
}
