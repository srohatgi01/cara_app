// To parse this JSON data, do
//
//     final updateAppointmentStatus = updateAppointmentStatusFromJson(jsonString);

import 'dart:convert';

class UpdateAppointmentStatus {
  UpdateAppointmentStatus({
    required this.appointmentStatus,
  });

  final String appointmentStatus;

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "appointment_status": appointmentStatus,
      };
}
