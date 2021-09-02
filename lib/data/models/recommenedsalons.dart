// To parse this JSON data, do
//
//     final recommendedSalons = recommendedSalonsFromJson(jsonString);

import 'dart:convert';

class RecommendedSalons {
  RecommendedSalons({
    this.salonId,
    this.salonName,
    this.logo,
    this.average,
  });

  final int? salonId;
  final String? salonName;
  final String? logo;
  final String? average;

  factory RecommendedSalons.fromRawJson(String str) =>
      RecommendedSalons.fromJson(json.decode(str));

  factory RecommendedSalons.fromJson(Map<String, dynamic> json) =>
      RecommendedSalons(
        salonId: json["salon_id"] == null ? null : json["salon_id"],
        salonName: json["salon_name"] == null ? null : json["salon_name"],
        logo: json["logo"],
        average: json["average"] == null ? null : json["average"],
      );
}
