import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _sharedPreferences;
  static Prefs? _instance;

  static Future<Prefs> init() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    if (_instance == null) {
      _instance = Prefs();
    }

    return _instance!;
  }

  isSignedIn() async {
    try {
      var signedIn;
      signedIn = _sharedPreferences!.getBool('isSignedIn');
      print('isSignedIn - ' + signedIn.toString());
      return signedIn;
    } catch (e) {
      print('Error in retreving isSignedIn = $e');
    }
  }

  authScreenStatus() async {
    try {
      var authScreenStatus;
      authScreenStatus = _sharedPreferences!.getBool('shouldShowAuth');
      print('showAuthScreen - ' + authScreenStatus.toString());
      return authScreenStatus;
    } catch (e) {
      print('Error in retreving authScreenStatus = $e');
    }
  }

  dontShowAuthScreen() async {
    try {
      _sharedPreferences!.setBool('shouldShowAuth', false);
    } catch (e) {
      print('Error in setting shouldShowSuth as false = $e');
    }
  }

  showAuthScreen() async {
    try {
      _sharedPreferences!.setBool('shouldShowAuth', true);
    } catch (e) {
      print('Error setting shouldShowSuth as true = $e');
    }
  }

  signInUser() async {
    try {
      await _sharedPreferences!.setBool('isSignedIn', true);
    } catch (e) {
      print('Error making the key, isSignedIn = $e');
    }
  }

  logout() async {
    try {
      await _sharedPreferences!.setBool('isSignedIn', false);
    } catch (e) {
      print('Error in logging out user');
    }
  }
}
