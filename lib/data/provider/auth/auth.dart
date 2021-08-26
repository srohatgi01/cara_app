import 'package:cara_app/data/config/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signIn() async {
    var initialized = false;
    try {
      await Firebase.initializeApp();
      initialized = true;
    } catch (e) {
      print(e);
    }
    if (initialized) {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await firebaseAuth.signInWithCredential(googleAuthCredential);

      final User user = firebaseAuth.currentUser!;

      // print('Google User - $user');

      return user;
    } else {
      print("Not initialized");
    }
  }

  // isNewUser(String emailAddress) async {
  //   Response response = await UserApi().fetchUser(emailAddress: emailAddress);

  //   if (response.statusCode == 404) {
  //     return true;
  //   } else if (response.statusCode == 200) {
  //     CustomUser.User user = CustomUser.User.fromRawJson(response.body);
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('gender', user.gender!);
  //     prefs.setString('phoneNumber', user.phoneNumber!);

  //     return user;
  //   }
  // }

  // createUserInDatabase(String json) async {
  //   var createdUser = await UserApi().createUser(json: json);

  //   print("User created");

  //   CustomUser.User user = CustomUser.User.fromRawJson(createdUser.body);
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('gender', user.gender!);
  //   prefs.setString('phoneNumber', user.phoneNumber!);

  //   return user;
  // }

  signOut() async {
    await googleSignIn.signOut();

    // Update shared Prefences
    var prefs = await Prefs.init();
    prefs.logout();
    prefs.showAuthScreen();
    prefs.deleteUserDetails();
    print("Sign Out Successfully");
  }

  // disconnect() async {
  //   await googleSignIn.disconnect();
  //   print("Disconnected Successfully");
  // }
}
