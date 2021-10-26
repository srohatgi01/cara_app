import 'package:cara_app/constants/colors.dart';
import 'package:cara_app/constants/strings.dart';
import 'package:cara_app/data/models/carauser.dart';
import 'package:cara_app/data/models/guser.dart';
import 'package:cara_app/data/repositories/user_repo.dart';
import 'package:cara_app/presentation/dashboard.dart';
import 'package:cara_app/presentation/authentication/get_phone_number_screen.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/google_sign_in.dart';

class GoogleAuthScreen extends StatefulWidget {
  const GoogleAuthScreen({Key? key}) : super(key: key);

  @override
  _GoogleAuthScreenState createState() => _GoogleAuthScreenState();
}

class _GoogleAuthScreenState extends State<GoogleAuthScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(backgroundColor),
      body: SafeArea(
        child: loading == false
            ? Stack(
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
                            style:
                                TextStyle(fontFamily: 'Signatra', fontSize: 120, color: Theme.of(context).primaryColor),
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
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Column signUp({required BuildContext context}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            print('SignUp/SignIn Button was pressed.');
            loading = true;
            setState(() {});
            dynamic response = await UserRepository().authenticate();
            print('type - ' + response.runtimeType.toString());
            if (response is GUser) {
              print('User not found \n Navigating to get phoneNumber');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Provider<GUser>(
                      create: (context) => response,
                      child: GetPhoneNumberScreen(),
                    ),
                  ));
            } else if (response is CaraUser) {
              //Providing the user to the function
              UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

              userProvider.setUser(response);
              userProvider.changeUserAuthStatus(isSignedIn: true, shouldShowAuth: false);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(),
                ),
              );
            }
          },
          child: GoogleSignIn(),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'or',
              style: TextStyle(
                fontSize: 13,
                fontFamily: 'NexaBoldDemo',
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                // signInlater(context: context);
                Provider.of<UserProvider>(context, listen: false)
                    .changeUserAuthStatus(isSignedIn: false, shouldShowAuth: false);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
              },
              child: Text(
                'Sign In later',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NexaBoldDemo',
                  fontSize: 13,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
