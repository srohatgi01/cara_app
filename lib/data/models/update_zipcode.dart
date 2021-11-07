// To parse this JSON data, do
//
//     final updateZipCode = updateZipCodeFromJson(jsonString);

import 'dart:convert';

class UpdateZipCode {
  UpdateZipCode({
    required this.zipcode,
  });

  final String zipcode;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "zipcode": zipcode,
      };
}
