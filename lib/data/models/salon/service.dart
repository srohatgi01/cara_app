import 'dart:convert';

class Service {
  Service({
    this.serviceId,
    this.categoryId,
    this.serviceName,
    this.servicePrice,
    this.description,
  });

  final int? serviceId;
  final int? categoryId;
  final String? serviceName;
  final String? servicePrice;
  final String? description;

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceId: json["service_id"] == null ? null : json["service_id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        serviceName: json["service_name"] == null ? null : json["service_name"],
        servicePrice:
            json["service_price"] == null ? null : json["service_price"],
        description: json["description"] == null ? null : json["description"],
      );
}
