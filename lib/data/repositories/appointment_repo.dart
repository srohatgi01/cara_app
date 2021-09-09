import 'package:cara_app/data/models/appointment/bookappointment.dart';
import 'package:cara_app/data/models/salon/service.dart';
import 'package:cara_app/data/models/slot.dart';
import 'package:cara_app/data/provider/appointment.dart';

class AppointmentRepo {
  AppointmentApi _appointmentApi = AppointmentApi();

  getSlots({required String date, required String salonId, String? chairNumber}) async {
    var decodedResponse = await _appointmentApi.getSlots(date: date, salonId: salonId, chairNumber: chairNumber);
    List<Slot> slots = [];

    if (decodedResponse.length > 0 && decodedResponse != null) {
      for (var slot in decodedResponse) {
        slots.add(Slot.fromJson(slot));
      }

      return slots;
    }
  }

  bookAppointment({
    required List<Service> services,
    required String userId,
    required int salonId,
    required String chairNumber,
    required String dateOfAppointment,
    required String totalPrice,
    required int slotId,
  }) async {
    List<AppointmentDetail> appointmentDetails = [];
    print('aaa$chairNumber' + 'aaa');
    for (var service in services) {
      appointmentDetails.add(
        AppointmentDetail(serviceId: service.serviceId!),
      );
    }

    var encodedJsonBody = BookAoppointment(
      userId: userId,
      salonId: salonId,
      chairNumber: chairNumber,
      dateOfAppointment: dateOfAppointment,
      totalPrice: totalPrice,
      slotId: slotId,
      appointmentDetails: appointmentDetails,
    ).toRawJson();

    print(encodedJsonBody);

    var response = await _appointmentApi.bookAppointment(body: encodedJsonBody);

    if (response is String) {
      return response;
    }
  }
}
