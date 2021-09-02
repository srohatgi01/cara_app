import 'package:cara_app/data/models/salon/service.dart';
import 'package:flutter/cupertino.dart';

class SalonProvider with ChangeNotifier {
  var _salonId;
  List<Service> _services = [];

  get getSalonId => _salonId;
  get getServices => _services;

  set setSalonId(var salonId) {
    _salonId = salonId;
    notifyListeners();
  }

  doesContain({required Service service}) {
    if (_services.contains(service))
      return true;
    else
      return false;
  }

  addToCart({required Service service}) {
    if (!_services.contains(service)) {
      _services.add(service);
      print(service.serviceName);
      notifyListeners();
    }
  }

  removeFromCart({required Service service}) {
    if (_services.contains(service)) {
      _services.remove(service);
      notifyListeners();
    }
  }
}
