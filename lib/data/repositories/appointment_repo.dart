import 'package:cara_app/data/models/slot.dart';
import 'package:cara_app/data/provider/appointment.dart';

class AppointmentRepo {
  AppointmentApi _appointmentApi = AppointmentApi();

  getSlots({required String date, required String salonId, String? chairNumber}) async {
    var decodedResponse = await _appointmentApi.getSlots(date: date, salonId: salonId, chairNumber: chairNumber);
    List<Slot> slots = [];

    if (decodedResponse.length > 0) {
      for (var slot in decodedResponse) {
        slots.add(Slot.fromJson(slot));
      }

      return slots;
    }
  }
}
