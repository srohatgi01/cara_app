import 'package:cara_app/data/models/carauser.dart';
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

  saveUserDetails({
    required String emailAddress,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String zipCode,
    required String photoUrl,
  }) async {
    try {
      await _sharedPreferences!.setString('emailAddress', '$emailAddress');
      await _sharedPreferences!.setString('firstName', '$firstName');
      await _sharedPreferences!.setString('lastName', '$lastName');
      await _sharedPreferences!.setString('phoneNumber', '$phoneNumber');
      await _sharedPreferences!.setString('zipCode', '$zipCode');
      await _sharedPreferences!.setString('photoUrl', '$photoUrl');
    } catch (e) {
      print('Error in setting user data');
    }
  }

  getUserDetails() async {
    try {
      var emailAddress = _sharedPreferences!.getString('emailAddress');
      var firstName = _sharedPreferences!.getString('firstName');
      var lastName = _sharedPreferences!.getString('lastName');
      var phoneNumber = _sharedPreferences!.getString('phoneNumber');
      var zipCode = _sharedPreferences!.getString('zipCode');
      var photoUrl = _sharedPreferences!.getString('photoUrl');

      return CaraUser(
        emailAddress: emailAddress,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        zipcode: zipCode,
        photoUrl: photoUrl,
      );
    } catch (e) {
      print('Error in setting user data');
    }
  }

  updateZipCode({required String zipCode}) async {
    try {
      await _sharedPreferences!.setString('zipCode', zipCode);
    } catch (e) {
      print('Error in setting user data');
    }
  }

  deleteUserDetails() async {
    try {
      await _sharedPreferences!.remove('emailAddress');
      await _sharedPreferences!.remove('firstName');
      await _sharedPreferences!.remove('lastName');
      await _sharedPreferences!.remove('phoneNumber');
      await _sharedPreferences!.remove('zipCode');
      await _sharedPreferences!.remove('photoUrl');
    } catch (e) {
      print('Error in deleting user data');
    }
  }
}
