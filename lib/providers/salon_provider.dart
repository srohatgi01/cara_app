import 'package:cara_app/data/models/salon/service.dart';
import 'package:flutter/cupertino.dart';

class SalonProvider with ChangeNotifier {
  var _salonId;
  List<Service> _services = [];
  int _subtotal = 0;

  get getSalonId => _salonId;
  get getServices => _services;
  get subtotal => _subtotal;

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
      _subtotal += int.parse(service.servicePrice!);
      print(service.serviceName);
      notifyListeners();
    }
  }

  removeFromCart({required Service service}) {
    if (_services.contains(service)) {
      _services.remove(service);
      _subtotal -= int.parse(service.servicePrice!);
      notifyListeners();
    }
  }

  emptyCart() {
    _services.clear();
    _subtotal = 0;
    _salonId = null;
    notifyListeners();
  }
}
