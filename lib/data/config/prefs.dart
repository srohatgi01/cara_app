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

  initialCheck() async {
    try {
      if (_sharedPreferences!.containsKey('isSignedIn') == false &&
          _sharedPreferences!.containsKey('shouldShowAuth') == false) {
        await authStatus(isSignedIn: false, shouldShowAuth: true);
      }
    } catch (e) {
      print('$e');
    }
  }

  authStatus({required bool isSignedIn, required bool shouldShowAuth}) async {
    try {
      await _sharedPreferences!.setBool('isSignedIn', isSignedIn);
      await _sharedPreferences!.setBool('shouldShowAuth', shouldShowAuth);
    } catch (e) {
      print('$e');
    }
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

  shouldShowAuth() async {
    try {
      var authScreenStatus;
      authScreenStatus = _sharedPreferences!.getBool('shouldShowAuth');
      print('showAuthScreen - ' + authScreenStatus.toString());
      return authScreenStatus;
    } catch (e) {
      print('Error in retreving authScreenStatus = $e');
    }
  }

  saveUserDetails({required CaraUser cuser}) async {
    try {
      await _sharedPreferences!
          .setString('emailAddress', '${cuser.emailAddress}');
      await _sharedPreferences!.setString('firstName', '${cuser.firstName}');
      await _sharedPreferences!.setString('lastName', '${cuser.lastName}');
      await _sharedPreferences!
          .setString('phoneNumber', '${cuser.phoneNumber}');
      await _sharedPreferences!.setString('zipCode', '${cuser.zipcode}');
      await _sharedPreferences!.setString('photoUrl', '${cuser.photoUrl}');
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
      // Return the default zipcode of bhopal if user is not signed in.
      var zipCode = _sharedPreferences!.getString('zipCode') ?? '462000';
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
