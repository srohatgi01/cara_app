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

  signOut() async {
    await googleSignIn.signOut();
  }

  // disconnect() async {
  //   await googleSignIn.disconnect();
  //   print("Disconnected Successfully");
  // }
}
