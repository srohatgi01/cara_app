import 'package:cara_app/data/models/salon/service.dart';
import 'package:cara_app/data/models/slot.dart';
import 'package:cara_app/data/repositories/appointment_repo.dart';
import 'package:cara_app/providers/appointment_provider.dart';
import 'package:cara_app/providers/salon_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CalendarController _calendarController = CalendarController();
  List<Service> services = [];
  @override
  Widget build(BuildContext context) {
    services = Provider.of<SalonProvider>(context).getServices;
    // ListView to display all the services
    var servicesListView = ListView.builder(
        shrinkWrap: true,
        itemCount: services.length,
        itemBuilder: (context, index) => Dismissible(
              key: Key(services[index].serviceId.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                child: Text('Remove'),
                alignment: Alignment.centerRight,
                color: Colors.red,
              ),
              onDismissed: (direction) {
                {
                  Provider.of<SalonProvider>(context, listen: false).removeFromCart(service: services[index]);
                }
              },
              child: ListTile(
                title: Text(services[index].serviceName!),
                // subtitle: Text(services[index].servicePrice!),
                subtitle: Text(services[index].serviceId!.toString()),
              ),
            ));

    // Widget to show the subtotal of the price of the services selected
    var subtotal = Container(child: Text('₹' + Provider.of<SalonProvider>(context).subtotal.toString()));

    var getSlotsFuture = AppointmentRepo().getSlots(
        date: Provider.of<AppointmentProvider>(context).getDate,
        salonId: Provider.of<SalonProvider>(context).getSalonId.toString(),
        chairNumber: Provider.of<AppointmentProvider>(context).getIsChairSelected == true
            ? Provider.of<AppointmentProvider>(context).getSelectedNumberOfChair.toString()
            : null);

    var getSlots = FutureBuilder(
        future: getSlotsFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
            List<Slot> slots = snapshot.data as List<Slot>;
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: slots.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(slots[index].startTime!),
                subtitle: Text(
                  slots[index].slotId!.toString(),
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('Something went wrong'),
            );
          }
        });

    var calendar = Container(
        height: 150,
        child: SfCalendar(
          minDate: DateTime.now(),
          maxDate: DateTime.now().add(Duration(days: 10)),
          firstDayOfWeek: 1,
          view: CalendarView.month,
          viewHeaderHeight: 40,
          headerHeight: 50,
          initialDisplayDate: DateTime.now(),
          // initialSelectedDate: DateTime.now(),
          headerStyle: CalendarHeaderStyle(
            backgroundColor: Theme.of(context).primaryColor,
            textAlign: TextAlign.center,
            textStyle: TextStyle(color: Colors.white, fontSize: 22),
          ),
          cellEndPadding: 0,
          showNavigationArrow: true,
          // cellBorderColor: Colors.transparent,
          controller: _calendarController,
          monthCellBuilder: (context, MonthCellDetails details) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Text(details.date.day.toString()),
            );
          },
          onSelectionChanged: (date) {
            var fullDate;
            var day = date.date!.day;
            var month = date.date!.month;
            var year = date.date!.year;

            if (month < 10 && day < 10) {
              fullDate = '$year-0$month-0$day';
            } else if (month >= 10 && day < 10) {
              fullDate = '$year-$month-0$day';
            } else if (month < 10 && day >= 10) {
              fullDate = '$year-0$month-$day';
            } else if (month >= 10 && day >= 10) {
              fullDate = '$year-$month-$day';
            } else
              throw RangeError;

            Provider.of<AppointmentProvider>(context, listen: false).setDate = fullDate;
          },
          monthViewSettings: MonthViewSettings(
            showTrailingAndLeadingDates: false,
            navigationDirection: MonthNavigationDirection.horizontal,
            numberOfWeeksInView: 1,
            dayFormat: 'EEE',
          ),
        ));

    var chairs = Container(
        width: 65,
        child: ListView.builder(
            itemCount: Provider.of<AppointmentProvider>(context).getNumberOfChairs,
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    print(index + 1);
                    Provider.of<AppointmentProvider>(context, listen: false).setSelectedNumberOfChair = index;
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    color: Colors.red,
                    height: 45,
                    width: 45,
                    child: Text(Provider.of<AppointmentProvider>(context).getNumberOfChairs.toString()),
                  ),
                )));

    var viewForAll = ElevatedButton(
      onPressed: () {
        Provider.of<AppointmentProvider>(context, listen: false).unSelectedChair();
      },
      child: Text('Clear Selection'),
    );

    var appointmentButton = Container(
      margin: EdgeInsets.symmetric(vertical: 40),
      height: 50,
      width: 300,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('Book Appointment'),
      ),
    );

    //Main page code
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            servicesListView,
            subtotal,
            calendar,
            getSlots,
            chairs,
            viewForAll,
            appointmentButton,
          ],
        ),
      ),
    );
  }
}
