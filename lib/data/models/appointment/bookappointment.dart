// To parse this JSON data, do
//
//     final bookAoppointment = bookAoppointmentFromJson(jsonString);

import 'dart:convert';

class BookAoppointment {
  BookAoppointment({
    required this.userId,
    required this.salonId,
    required this.chairNumber,
    required this.dateOfAppointment,
    required this.totalPrice,
    required this.slotId,
    required this.appointmentDetails,
  });

  final String userId;
  final int salonId;
  final String chairNumber;
  final String dateOfAppointment;
  final String totalPrice;
  final int slotId;
  final List<AppointmentDetail> appointmentDetails;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "salon_id": salonId,
        "chair_number": chairNumber,
        "date_of_appointment": dateOfAppointment + "T00:00:00.000Z",
        "total_price": totalPrice,
        "slot_id": slotId,
        "appointment_details": List<dynamic>.from(appointmentDetails.map((x) => x.toJson())),
      };
}

class AppointmentDetail {
  AppointmentDetail({
    required this.serviceId,
  });

  final int serviceId;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
      };
}
