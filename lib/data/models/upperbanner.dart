// To parse this JSON data, do
//
//     final upperBanner = upperBannerFromJson(jsonString);

import 'dart:convert';

class UpperBanner {
  UpperBanner({
    this.salonId,
    this.bannerPositionNumber,
    this.bannerUrl,
  });

  final int? salonId;
  final String? bannerPositionNumber;
  final String? bannerUrl;

  factory UpperBanner.fromRawJson(String str) =>
      UpperBanner.fromJson(json.decode(str));

  factory UpperBanner.fromJson(Map<String, dynamic> json) => UpperBanner(
        salonId: json["salon_id"] == null ? null : json["salon_id"],
        bannerPositionNumber: json["banner_position_number"] == null
            ? null
            : json["banner_position_number"],
        bannerUrl: json["banner_url"] == null ? null : json["banner_url"],
      );
}
