import 'package:flutter/cupertino.dart';

class AppointmentProvider with ChangeNotifier {
  var _date;
  late int? _numberofChairs;
  int? _selectedNumberOfChair;
  bool _isChairSelected = false;
  var _selectedSlotId = 'no slot selected';

  AppointmentProvider({required numberOfChairs}) {
    this._numberofChairs = numberOfChairs;
    this._date = filterDate(DateTime.now());
  }

  get getDate => _date;
  get getNumberOfChairs => _numberofChairs;
  get getSelectedNumberOfChair => _selectedNumberOfChair;
  get getIsChairSelected => _isChairSelected;
  get getSelectedSlotId => _selectedSlotId;

  set setSlotId(var slotId) {
    _selectedSlotId = slotId;
    notifyListeners();
  }

  set setDate(String date) {
    _date = date;
    notifyListeners();
  }

  set setSelectedNumberOfChair(int? number) {
    number != null ? _selectedNumberOfChair = number + 1 : _selectedNumberOfChair = null;
    _isChairSelected = true;
    notifyListeners();
  }

  unSelectedChair() {
    _isChairSelected = false;
    notifyListeners();
  }

  filterDate(DateTime date) {
    String fullDate = '';
    var day = date.day;
    var month = date.month;
    var year = date.year;

    if (month < 10 && day < 10) {
      fullDate = '$year-0$month-0$day';
    } else if (month >= 10 && day < 10) {
      fullDate = '$year-$month-0$day';
    } else if (month < 10 && day >= 10) {
      fullDate = '$year-0$month-$day';
    } else if (month >= 10 && day >= 10) {
      fullDate = '$year-$month-$day';
    }

    return fullDate;
  }
}
