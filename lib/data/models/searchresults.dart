// To parse this JSON data, do
//
//     final searchResults = searchResultsFromJson(jsonString);

import 'dart:convert';

class SearchResults {
  SearchResults({
    this.salonId,
    this.salonName,
    this.addressLineOne,
    this.addressLineTwo,
    this.logo,
    this.salonType,
  });

  final int? salonId;
  final String? salonName;
  final String? addressLineOne;
  final String? addressLineTwo;
  final String? logo;
  final String? salonType;

  factory SearchResults.fromRawJson(String str) =>
      SearchResults.fromJson(json.decode(str));

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        salonId: json["salon_id"] == null ? null : json["salon_id"],
        salonName: json["salon_name"] == null ? null : json["salon_name"],
        addressLineOne:
            json["address_line_one"] == null ? null : json["address_line_one"],
        addressLineTwo: json["address_line_two"],
        logo: json["logo"],
        salonType: json["salon_type"] == null ? null : json["salon_type"],
      );
}
