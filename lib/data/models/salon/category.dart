import 'dart:convert';

import 'package:cara_app/data/models/salon/service.dart';

class Category {
  Category({
    this.categoryId,
    this.salonId,
    this.categoryName,
    this.services,
  });

  final int? categoryId;
  final int? salonId;
  final String? categoryName;
  final List<Service>? services;

  factory Category.fromRawJson(String str) =>
      Category.fromJson(json.decode(str));

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"] == null ? null : json["category_id"],
        salonId: json["salon_id"] == null ? null : json["salon_id"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        services: json["services"] == null
            ? null
            : List<Service>.from(
                json["services"].map((x) => Service.fromJson(x))),
      );
}
