import 'package:cara_app/constants/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpperBannerApi {
  fetchUpperBanner({required String zipCode}) async {
    try {
      var response = await http.get(Uri.parse(upperBannerUrl + zipCode));

      return jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }
}
