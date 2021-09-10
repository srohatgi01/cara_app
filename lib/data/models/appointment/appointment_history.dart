// To parse this JSON data, do
//
//     final appointmentHistory = appointmentHistoryFromJson(jsonString);

import 'dart:convert';

class AppointmentHistory {
  AppointmentHistory({
    required this.appointmentId,
    required this.appointmentStamp,
    required this.totalPrice,
    required this.dateOfAppointment,
    required this.appointmentStatus,
    required this.appointmentDetails,
    required this.salon,
    required this.slots,
  });

  final int? appointmentId;
  final DateTime? appointmentStamp;
  final String? totalPrice;
  final DateTime? dateOfAppointment;
  final String? appointmentStatus;
  final List<AppointmentHistoryAppointmentDetail>? appointmentDetails;
  final AppointmentHistorySalon? salon;
  final AppointmentHistorySlots? slots;

  factory AppointmentHistory.fromRawJson(String str) => AppointmentHistory.fromJson(json.decode(str));

  factory AppointmentHistory.fromJson(Map<String, dynamic> json) => AppointmentHistory(
        appointmentId: json["appointment_id"] == null ? null : json["appointment_id"],
        appointmentStamp: json["appointment_stamp"] == null ? null : DateTime.parse(json["appointment_stamp"]),
        totalPrice: json["total_price"] == null ? null : json["total_price"],
        dateOfAppointment: json["date_of_appointment"] == null ? null : DateTime.parse(json["date_of_appointment"]),
        appointmentStatus: json["appointment_status"] == null ? null : json["appointment_status"],
        appointmentDetails: json["appointment_details"] == null
            ? null
            : List<AppointmentHistoryAppointmentDetail>.from(
                json["appointment_details"].map((x) => AppointmentHistoryAppointmentDetail.fromJson(x))),
        salon: json["salon"] == null ? null : AppointmentHistorySalon.fromJson(json["salon"]),
        slots: json["slots"] == null ? null : AppointmentHistorySlots.fromJson(json["slots"]),
      );
}

class AppointmentHistoryAppointmentDetail {
  AppointmentHistoryAppointmentDetail({
    required this.services,
  });

  final AppointmentHistoryServices? services;

  factory AppointmentHistoryAppointmentDetail.fromRawJson(String str) =>
      AppointmentHistoryAppointmentDetail.fromJson(json.decode(str));

  factory AppointmentHistoryAppointmentDetail.fromJson(Map<String, dynamic> json) =>
      AppointmentHistoryAppointmentDetail(
        services: json["services"] == null ? null : AppointmentHistoryServices.fromJson(json["services"]),
      );
}

class AppointmentHistoryServices {
  AppointmentHistoryServices({
    required this.serviceName,
    required this.servicePrice,
  });

  final String serviceName;
  final String servicePrice;

  factory AppointmentHistoryServices.fromRawJson(String str) => AppointmentHistoryServices.fromJson(json.decode(str));

  factory AppointmentHistoryServices.fromJson(Map<String, dynamic> json) => AppointmentHistoryServices(
        serviceName: json["service_name"] == null ? null : json["service_name"],
        servicePrice: json["service_price"] == null ? null : json["service_price"],
      );
}

class AppointmentHistorySalon {
  AppointmentHistorySalon({
    required this.salonId,
    required this.salonName,
    required this.logo,
  });

  final int salonId;
  final String salonName;
  final String? logo;

  factory AppointmentHistorySalon.fromRawJson(String str) => AppointmentHistorySalon.fromJson(json.decode(str));

  factory AppointmentHistorySalon.fromJson(Map<String, dynamic> json) => AppointmentHistorySalon(
        salonId: json["salon_id"] == null ? null : json["salon_id"],
        salonName: json["salon_name"] == null ? null : json["salon_name"],
        logo: json["logo"] == null ? null : json["logo"],
      );
}

class AppointmentHistorySlots {
  AppointmentHistorySlots({
    required this.startTime,
  });

  final String startTime;

  factory AppointmentHistorySlots.fromRawJson(String str) => AppointmentHistorySlots.fromJson(json.decode(str));

  factory AppointmentHistorySlots.fromJson(Map<String, dynamic> json) => AppointmentHistorySlots(
        startTime: json["start_time"] == null ? null : json["start_time"],
      );
}
