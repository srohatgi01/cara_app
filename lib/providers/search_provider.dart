import 'package:flutter/cupertino.dart';

class SearchProvider with ChangeNotifier {
  String? _keyword;

  set setKeyword(String keyword) {
    _keyword = keyword;
    notifyListeners();
  }

  get getKeyword => _keyword;
}
