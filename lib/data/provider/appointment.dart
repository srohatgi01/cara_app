import 'dart:convert';

import 'package:cara_app/constants/strings.dart';
import 'package:http/http.dart' as http;

class AppointmentApi {
  //this will return the available slots for the particular salon and chair number.
  // if chair number is not provided then it will return all the time slots.
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

  /* 
    This function will take ecoded body in form of string and then post it.
    if the post requrest is successful then it will return the decoded json body which will be recieved from the api. else it will return something else;
   */
  bookAppointment({required String body}) async {
    try {
      var response = await http.post(
        Uri.parse(bookAppointmentUrl),
        body: body,
        headers: <String, String>{HEADER_DETAILS_KEY: HEADER_DETAILS_VALUE},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  appointmentHistory({required String emailAddress}) async {
    try {
      var response = await http.get(Uri.parse(getUserAppointmentsUrl + emailAddress));

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e);
    }
  }
}
