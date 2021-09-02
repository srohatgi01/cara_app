import 'dart:convert';

import 'package:cara_app/constants/strings.dart';
import 'package:http/http.dart' as http;

class SalonsApi {
  recommenedSalons({required String zipCode}) async {
    try {
      var response;
      if (zipCode != '462000') {
        response = await http.get(Uri.parse(recommendedSalonsUrl + zipCode));
      } else if (zipCode == '462000') {
        response = await http.get(Uri.parse(recommendedSalonsUrl));
      }

      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  searchSalons({required String keyword}) async {
    try {
      var response = await http.get(Uri.parse(searchSalonsUrl + keyword));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  getSalonById({required int id}) async {
    try {
      var response = await http.get(Uri.parse(getSalonByIdUrl + id.toString()));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
