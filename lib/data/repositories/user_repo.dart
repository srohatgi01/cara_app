import 'package:cara_app/data/config/prefs.dart';
import 'package:cara_app/data/models/carauser.dart';
import 'package:cara_app/data/models/guser.dart';
import 'package:cara_app/data/provider/auth/auth.dart';
import 'package:cara_app/data/provider/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  authenticate() async {
    // Sign In with Google Auth and returns a User object with all the details from Google User object.
    User user = await Auth().signIn();

    GUser guser = GUser.fromGoogleUser(user: user);

    dynamic response = await UserApi().fetchUser(emailAddress: guser.email);

    if (response == 404) {
      return guser;
    } else if (response is http.Response) {
      CaraUser user = CaraUser.fromRawJson(response.body);

      // Update shared prefences
      var prefs = await Prefs.init();

      prefs.dontShowAuthScreen();
      prefs.signInUser();

      return user;
    }
  }

  postUser({required CaraUser cuser}) async {
    String body = cuser.toRawJson();
    var response = await UserApi().postUser(body: body);

    CaraUser user = CaraUser.fromRawJson(response.body);

    // Update shared prefences
    var prefs = await Prefs.init();

    prefs.dontShowAuthScreen();
    prefs.signInUser();
    await prefs.saveUserDetails(
      emailAddress: user.emailAddress!,
      firstName: user.firstName!,
      lastName: user.lastName!,
      phoneNumber: user.phoneNumber!,
      zipCode: user.zipcode!,
      photoUrl: user.photoUrl!,
    );

    return user;
  }

  getUser() async {
    var prefs = await Prefs.init();

    CaraUser cuser = await prefs.getUserDetails();

    return cuser;
  }
}
