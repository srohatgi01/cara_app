import 'package:cara_app/data/config/prefs.dart';
import 'package:cara_app/data/models/carauser.dart';
import 'package:cara_app/data/models/guser.dart';
import 'package:cara_app/data/repositories/user_repo.dart';
import 'package:cara_app/presentation/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetPhoneNumberScreen extends StatelessWidget {
  const GetPhoneNumberScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GUser gUser = Provider.of<GUser>(context);

    return Container(
      child: Scaffold(
        body: Center(
          child: Column(
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

                    CaraUser cuser =
                        await UserRepository().postUser(cuser: user);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Provider<CaraUser>(
                            create: (context) => cuser,
                            child: Dashboard(),
                          ),
                        ));
                  },
                  child: Text('Create User')),
            ],
          ),
        ),
      ),
    );
  }
}
