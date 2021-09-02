import 'package:cara_app/data/config/prefs.dart';
import 'package:cara_app/data/models/carauser.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  var _isSignedIn;
  var _shouldShowAuth;
  var _cuser;

  UserProvider() {
    _isSignedIn = false;
    _shouldShowAuth = true;
    loadPrefrences();
    notifyListeners();
  }
  get isSignedIn => _isSignedIn;
  get shouldShowAuth => _shouldShowAuth;
  get cuser => _cuser;

  changeUserAuthStatus({
    required bool isSignedIn,
    required bool shouldShowAuth,
  }) async {
    _isSignedIn = isSignedIn;
    _shouldShowAuth = shouldShowAuth;
    notifyListeners();

    var _prefs = await Prefs.init();

    await _prefs.authStatus(
      isSignedIn: isSignedIn,
      shouldShowAuth: shouldShowAuth,
    );
  }

  setUser(CaraUser user) async {
    _cuser = user;
    notifyListeners();
    var _prefs = await Prefs.init();
    _prefs.saveUserDetails(cuser: user);
  }

  loadPrefrences() async {
    var _prefs = await Prefs.init();
    _isSignedIn = await _prefs.isSignedIn();
    _shouldShowAuth = await _prefs.shouldShowAuth();
    var user = await _prefs.getUserDetails();

    user != null ? _cuser = user : _cuser = null;
    notifyListeners();
  }

  updateZipCode({required String zipCode}) async {
    var _prefs = await Prefs.init();
    _prefs.updateZipCode(zipCode: zipCode);
    _cuser.zip = zipCode;
    notifyListeners();
  }
}
