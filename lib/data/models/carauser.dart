// To parse this JSON data, do
//
//     final caraUser = caraUserFromJson(jsonString);

import 'dart:convert';

import 'package:cara_app/data/models/guser.dart';

class CaraUser {
  CaraUser({
    required this.emailAddress,
    required this.firstName,
    required this.lastName,
    this.gender,
    required this.zipcode,
    required this.phoneNumber,
    this.photoUrl,
    this.dateOfBirth,
    this.coins,
    this.city,
    this.joinstamp,
  });

  final String? emailAddress;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? zipcode;
  final String? phoneNumber;
  final String? photoUrl;
  final String? dateOfBirth;
  final int? coins;
  final int? city;
  final DateTime? joinstamp;

  factory CaraUser.fromRawJson(String str) =>
      CaraUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CaraUser.fromJson(Map<String, dynamic> json) => CaraUser(
        emailAddress:
            json["email_address"] == null ? null : json["email_address"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        gender: json["gender"] == null ? null : json["gender"],
        zipcode: json["zipcode"] == null ? null : json["zipcode"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        photoUrl: json["photo_url"],
        dateOfBirth: json["date_of_birth"],
        coins: json["coins"] == null ? null : json["coins"],
        city: json["city"] == null ? null : json["city"],
        joinstamp: json["joinstamp"] == null
            ? null
            : DateTime.parse(json["joinstamp"]),
      );

  Map<String, dynamic> toJson() => {
        "email_address": emailAddress == null ? null : emailAddress,
        "first_name": firstName == null ? null : firstName,
        "last_name": lastName == null ? null : lastName,
        "gender": gender == null ? null : gender,
        "zipcode": zipcode == null ? null : zipcode,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "photo_url": photoUrl,
        "date_of_birth": dateOfBirth,
        "coins": coins == null ? null : coins,
        "city": city == null ? null : city,
        "joinstamp": joinstamp == null ? null : joinstamp!.toIso8601String(),
      };

  factory CaraUser.fromGUser(GUser user) => CaraUser(
        emailAddress: user.email,
        firstName: user.firstName,
        lastName: user.lastName,
        zipcode: '462000',
        phoneNumber: user.phoneNumber,
        photoUrl: user.photoUrl,
      );

  factory CaraUser.fromPrefs({
    required String emailAddress,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String zipCode,
    required String photoUrl,
  }) =>
      CaraUser(
        emailAddress: emailAddress,
        firstName: firstName,
        lastName: lastName,
        zipcode: zipCode,
        phoneNumber: phoneNumber,
      );
}
