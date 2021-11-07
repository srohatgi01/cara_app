import 'package:cara_app/data/config/prefs.dart';
import 'package:cara_app/data/models/carauser.dart';
import 'package:cara_app/data/models/guser.dart';
import 'package:cara_app/data/models/update_zipcode.dart';
import 'package:cara_app/data/provider/auth/auth.dart';
import 'package:cara_app/data/provider/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  authenticate() async {
    // Sign In with Google Auth and returns a User object with all the details from Google User object.
    User user = await Auth().signIn();

    //Created GUser form the Google User object and took out the necessary things from it.
    GUser guser = GUser.fromGoogleUser(user: user);

    // Passed email Id from GUser to the fetch function which will return either user exists or not
    dynamic response = await UserApi().fetchUser(emailAddress: guser.email);
    print(response.toString());
    if (response == 404) {
      //if user does not exists in database then pass the guser to the UI
      return guser;
    } else if (response is http.Response) {
      // if user exists in the database then it will pass the user response and parse it in CaraUser type
      CaraUser cuser = CaraUser.fromRawJson(response.body);

      return cuser;
    }
  }

  postUser({required CaraUser cuser}) async {
    //take complete cara user and post it on the database
    String body = cuser.toRawJson();
    var response = await UserApi().postUser(body: body);
    // parse the user again to return it back to the UI
    CaraUser user = CaraUser.fromRawJson(response.body);

    // Now initialize prefs to don't show auth screen, sign in user and save the data in local storage.
    var prefs = await Prefs.init();

    // prefs.dontShowAuthScreen();
    // prefs.signInUser();
    await prefs.saveUserDetails(cuser: user);

    return user;
  }

  updateZipCode({required String emailAddress, required String zipCode}) async {
    String body = UpdateZipCode(zipcode: zipCode).toRawJson();

    await UserApi().updateZipCode(emailAddress: emailAddress, body: body);
  }

  getUser() async {
    var prefs = await Prefs.init();

    CaraUser cuser = await prefs.getUserDetails();

    return cuser;
  }

  logoutUser() async {
    await Auth().signOut();
    // Update shared Prefences
    var prefs = await Prefs.init();
    // prefs.logout();
    // prefs.showAuthScreen();
    prefs.deleteUserDetails();
    print("Sign Out Successfully");
  }
}
