import 'package:cara_app/data/models/carauser.dart';
import 'package:cara_app/data/models/guser.dart';
import 'package:cara_app/data/repositories/user_repo.dart';
import 'package:cara_app/presentation/dashboard.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetPhoneNumberScreen extends StatefulWidget {
  const GetPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  _GetPhoneNumberScreenState createState() => _GetPhoneNumberScreenState();
}

class _GetPhoneNumberScreenState extends State<GetPhoneNumberScreen> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    GUser gUser = Provider.of<GUser>(context);

    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: loading == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        autofocus: false,
                        textAlign: TextAlign.center,
                        maxLength: 10,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: new InputDecoration(
                          labelText: "Enter Phone Number",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        style: new TextStyle(
                          fontSize: 16,
                          fontFamily: "Poppins",
                        ),
                        validator: (val) {
                          if (val!.length == 0) {
                            return "Phone Number cannot be empty";
                          } else if (val.length != 10) {
                            return "Phone number must be 10 digits";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) async {
                          gUser.phoneNum = value;
                          print(gUser.phoneNumber);
                        },
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            CaraUser user = CaraUser.fromGUser(gUser);
                            loading = true;
                            setState(() {});
                            CaraUser cuser =
                                await UserRepository().postUser(cuser: user);
                            //Providing the user to the function
                            Provider.of<UserProvider>(context, listen: false)
                                .setUser(cuser);
                            Provider.of<UserProvider>(context, listen: false)
                                .changeUserAuthStatus(
                                    isSignedIn: true, shouldShowAuth: false);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(),
                              ),
                            );
                          },
                          child: Text('Create User')),
                    ],
                  )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
