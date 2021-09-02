import 'package:cara_app/data/repositories/user_repo.dart';
import 'package:cara_app/presentation/authentication/google_auth_screen.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({Key? key}) : super(key: key);

  @override
  _ProfilePageScreenState createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text('About'),
          onPressed: () {
            showAboutDialog(context: context);
          },
        ),
        ElevatedButton(
          child: Text('Licenses'),
          onPressed: () {
            showLicensePage(context: context);
          },
        ),
        Container(
          alignment: Alignment.center,
          child: Provider.of<UserProvider>(context).isSignedIn == true
              ? ElevatedButton(
                  child: Text('Logout'),
                  onPressed: () async {
                    Provider.of<UserProvider>(context, listen: false)
                        .changeUserAuthStatus(
                            isSignedIn: false, shouldShowAuth: true);
                    UserRepository().logoutUser();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoogleAuthScreen()));
                  },
                )
              : ElevatedButton(
                  child: Text('Proceed to Sign In'),
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoogleAuthScreen()));
                  },
                ),
        ),
      ],
    ));
  }
}
