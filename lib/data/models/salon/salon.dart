// To parse this JSON data, do
//
//     final salon = salonFromJson(jsonString);

import 'dart:convert';

import 'package:cara_app/data/models/salon/cara_standards.dart';
import 'package:cara_app/data/models/salon/category.dart';

class Salon {
  Salon({
    this.salonId,
    this.brandId,
    this.salonName,
    this.addressLineOne,
    this.addressLineTwo,
    this.addressLineThree,
    this.zipcode,
    this.emailAddress,
    this.contactNumber,
    this.logo,
    this.photos,
    this.website,
    this.joinstamp,
    this.openYear,
    this.openTime,
    this.closeTime,
    this.openWeekdays,
    this.numberOfChairs,
    this.city,
    this.salonType,
    this.categories,
    this.caraStandards,
  });

  final int? salonId;
  final int? brandId;
  final String? salonName;
  final String? addressLineOne;
  final String? addressLineTwo;
  final String? addressLineThree;
  final String? zipcode;
  final String? emailAddress;
  final String? contactNumber;
  final String? logo;
  final List<String>? photos;
  final String? website;
  final DateTime? joinstamp;
  final String? openYear;
  final DateTime? openTime;
  final DateTime? closeTime;
  final List<String>? openWeekdays;
  final int? numberOfChairs;
  final int? city;
  final String? salonType;
  final List<Category>? categories;
  final List<CaraStandard>? caraStandards;

  factory Salon.fromRawJson(String str) => Salon.fromJson(json.decode(str));

  factory Salon.fromJson(Map<String, dynamic> json) => Salon(
        salonId: json["salon_id"] == null ? null : json["salon_id"],
        brandId: json["brand_id"] == null ? null : json["brand_id"],
        salonName: json["salon_name"] == null ? null : json["salon_name"],
        addressLineOne:
            json["address_line_one"] == null ? null : json["address_line_one"],
        addressLineTwo:
            json["address_line_two"] == null ? null : json["address_line_two"],
        addressLineThree: json["address_line_three"] == null
            ? null
            : json["address_line_three"],
        zipcode: json["zipcode"] == null ? null : json["zipcode"],
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
        contactNumber:
            json["contact_number"] == null ? null : json["contact_number"],
        logo: json["logo"] == null ? null : json["logo"],
        photos: json["photos"] == null
            ? null
            : List<String>.from(json["photos"].map((x) => x)),
        website: json["website"] == null ? null : json["website"],
        joinstamp: json["joinstamp"] == null
            ? null
            : DateTime.parse(json["joinstamp"]),
        openYear: json["open_year"] == null ? null : json["open_year"],
        openTime: json["open_time"] == null
            ? null
            : DateTime.parse(json["open_time"]),
        closeTime: json["close_time"] == null
            ? null
            : DateTime.parse(json["close_time"]),
        openWeekdays: json["open_weekdays"] == null
            ? null
            : List<String>.from(json["open_weekdays"].map((x) => x)),
        numberOfChairs:
            json["number_of_chairs"] == null ? null : json["number_of_chairs"],
        city: json["city"] == null ? null : json["city"],
        salonType: json["salon_type"] == null ? null : json["salon_type"],
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        caraStandards: json["cara_standards"] == null
            ? null
            : List<CaraStandard>.from(
                json["cara_standards"].map((x) => CaraStandard.fromJson(x))),
      );
}
