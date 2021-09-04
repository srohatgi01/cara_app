import 'package:flutter/cupertino.dart';

class AppointmentProvider with ChangeNotifier {
  var _date;
  late int? _numberofChairs;
  var _selectedNumberOfChair;
  bool _isChairSelected = false;

  AppointmentProvider({required numberOfChairs}) {
    this._numberofChairs = numberOfChairs;
    this._date = filterDate(DateTime.now());
  }

  get getDate => _date;
  get getNumberOfChairs => _numberofChairs;
  get getSelectedNumberOfChair => _selectedNumberOfChair;
  get getIsChairSelected => _isChairSelected;

  set setDate(String date) {
    _date = date;
    notifyListeners();
  }

  set setSelectedNumberOfChair(int number) {
    _selectedNumberOfChair = number + 1;
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
