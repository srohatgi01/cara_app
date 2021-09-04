import 'dart:convert';

import 'package:cara_app/constants/strings.dart';
import 'package:http/http.dart' as http;

class AppointmentApi {
  getSlots({required String date, required String salonId, String? chairNumber}) async {
    try {
      var response;
      if (chairNumber != null) {
        response = await http.get(Uri.parse(getSlotsUrl + salonId + '/' + date + '/' + chairNumber));
      } else {
        response = await http.get(Uri.parse(getSlotsUrl + salonId + '/' + date));
      }
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
