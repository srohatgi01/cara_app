// To parse this JSON data, do
//
//     final slot = slotFromJson(jsonString);

import 'dart:convert';

class Slot {
  Slot({
    this.slotId,
    this.startTime,
    this.chairNumber,
  });

  final int? slotId;
  final String? startTime;
  final String? chairNumber;

  factory Slot.fromRawJson(String str) => Slot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        slotId: json["slot_id"] == null ? null : json["slot_id"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        chairNumber: json["chair_number"] == null ? null : json["chair_number"],
      );

  Map<String, dynamic> toJson() => {
        "slot_id": slotId == null ? null : slotId,
        "start_time": startTime == null ? null : startTime,
        "chair_number": chairNumber == null ? null : chairNumber,
      };
}
