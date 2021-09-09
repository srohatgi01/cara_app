import 'package:cara_app/data/models/slot.dart';
import 'package:cara_app/data/repositories/appointment_repo.dart';
import 'package:cara_app/data/repositories/user_repo.dart';
import 'package:flutter/cupertino.dart';

class SlotProvider extends ChangeNotifier {
  var _selectedSlotNumber;
  List<Slot> _slots = [];
  var _chairNoBySlot;

  get getSlots => _slots;
  get getSelectedSlot => _selectedSlotNumber;
  get getChairNoBySlot => _chairNoBySlot;

  set setSelectedSlot(var slot) {
    _selectedSlotNumber = slot;
    notifyListeners();
  }

  set setChairNumberBySlot(var num) {
    _chairNoBySlot = num;
    print(_chairNoBySlot);
    notifyListeners();
  }

  getSlotsFunc({required String date, required String salonId, String? chairNumber}) async {
    var slots = await AppointmentRepo().getSlots(date: date, salonId: salonId, chairNumber: chairNumber);
    if (slots != null) _slots = slots;
    notifyListeners();
  }
}
