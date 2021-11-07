import 'package:cara_app/data/models/salon/service.dart';
import 'package:cara_app/data/models/slot.dart';
import 'package:cara_app/data/repositories/appointment_repo.dart';
import 'package:cara_app/presentation/widgets/custom_progress_bar.dart';
import 'package:cara_app/providers/appointment_provider.dart';
import 'package:cara_app/providers/salon_provider.dart';
import 'package:cara_app/providers/slot_provider.dart';
import 'package:cara_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CalendarController _calendarController = CalendarController();
  var loading = false;
  List<Service> services = [];
  var selectedSlot;
  var selectedSlotId;

  @override
  Widget build(BuildContext context) {
    services = Provider.of<SalonProvider>(context).getServices;
    List<Slot> slotsFromProvider = Provider.of<SlotProvider>(context).getSlots ?? [];
    // ListView to display all the services
    var servicesListView = ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: services.length,
      itemBuilder: (context, index) => Dismissible(
        key: Key(services[index].serviceId.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          padding: const EdgeInsets.only(right: 10),
          child: Text('Remove', style: TextStyle(color: Colors.white)),
          alignment: Alignment.centerRight,
          color: Colors.red,
        ),
        onDismissed: (direction) {
          {
            Provider.of<SalonProvider>(context, listen: false).removeFromCart(service: services[index]);
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: ListTile(
            title: Text(services[index].serviceName!, style: TextStyle(fontFamily: 'RalewayMedium')),
            subtitle: Text('₹' + services[index].servicePrice!.toString()),
            trailing: IconButton(
              icon: Icon(Icons.delete_outline_outlined, color: Colors.red),
              onPressed: () {
                // Bottom snackbar
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                  content: Text('Swipe left to remove'),
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                ));
              },
            ),
          ),
        ),
      ),
    );

    // Widget to show the subtotal of the price of the services selected
    var subtotal = Container(
      child: Text(
        '₹' + Provider.of<SalonProvider>(context).subtotal.toString(),
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
    var getSlots;
    var chairNoBySlotId;
    // var getSlots = FutureBuilder(
    //     future: getSlotsFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
    //         List<Slot> slots = snapshot.data as List<Slot>;
    //         return ListView.builder(
    //           physics: NeverScrollableScrollPhysics(),
    //           shrinkWrap: true,
    //           itemCount: slots.length,
    //           itemBuilder: (context, index) => InkWell(
    //             onTap: () {
    //               // Provider.of<AppointmentProvider>(context, listen: false).setSlotId = slots[index].slotId.toString();
    //               // setState(() {
    //               // });
    //               selectedSlot = slots[index].slotId;
    //               setState(() {});
    //               print('slot index - $selectedSlot');
    //               // Provider.of<SlotProvider>(context, listen: false).setSelectedSlot = slots[index].slotId.toString();
    //               print("slot selected");
    //             },
    //             child: ListTile(
    //               title: Text(slots[index].startTime!),
    //               subtitle: Text(
    //                 slots[index].slotId!.toString(),
    //               ),
    //             ),
    //           ),
    //         );
    //       } else if (snapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       } else {
    //         return Center(
    //           child: Text('Something went wrong'),
    //         );
    //       }
    //     });

    if (slotsFromProvider.length > 0) {
      getSlots = GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.9),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: slotsFromProvider.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              selectedSlot = index;
              selectedSlotId = slotsFromProvider[index].slotId;
              print(selectedSlotId.runtimeType);
            });
            print(selectedSlotId);
            Provider.of<SlotProvider>(context, listen: false).setChairNumberBySlot =
                slotsFromProvider[index].chairNumber;
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: selectedSlot == index ? Theme.of(context).primaryColor.withOpacity(.6) : Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]),
            margin: EdgeInsets.all(10),
            child: Text(
              slotsFromProvider[index].startTime.toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: selectedSlot == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      );
    } else
      getSlots = Container(
        alignment: Alignment.center,
        height: 100,
        child: Text('Please select a date to display available slots', style: TextStyle(color: Colors.black54)),
      );

    var fullDate;
    var calendar = Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 150,
      child: SfCalendar(
        minDate: DateTime.now(),
        maxDate: DateTime.now().add(Duration(days: 7)),
        firstDayOfWeek: DateTime.now().weekday,
        view: CalendarView.month,
        viewHeaderHeight: 40,
        headerHeight: 50,
        initialDisplayDate: DateTime.now(),
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
          print(fullDate);
          loading = true;
          Provider.of<AppointmentProvider>(context, listen: false).setDate = fullDate;
          selectedSlot = null;
          var d = Provider.of<AppointmentProvider>(context, listen: false).getDate;
          var s = Provider.of<SalonProvider>(context, listen: false).getSalonId;
          int? c = Provider.of<AppointmentProvider>(context, listen: false).getSelectedNumberOfChair;
          print('s = $s');
          print('d = $d');

          c != null
              ? Provider.of<SlotProvider>(context, listen: false)
                  .getSlotsFunc(date: d, salonId: s.toString(), chairNumber: c.toString())
                  .then((val) {
                  loading = false;
                })
              : Provider.of<SlotProvider>(context, listen: false)
                  .getSlotsFunc(date: d, salonId: s.toString())
                  .then((val) {
                  loading = false;
                });
        },
        monthViewSettings: MonthViewSettings(
          showTrailingAndLeadingDates: false,
          navigationDirection: MonthNavigationDirection.horizontal,
          numberOfWeeksInView: 1,
          dayFormat: 'EEE',
        ),
      ),
    );

    var chairs = Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Provider.of<AppointmentProvider>(context).getNumberOfChairs,
        shrinkWrap: true,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print(index + 1);
            loading = true;
            setState(() {});
            Provider.of<AppointmentProvider>(context, listen: false).getSelectedNumberOfChair != index + 1
                ? Provider.of<AppointmentProvider>(context, listen: false).setSelectedNumberOfChair = index
                : Provider.of<AppointmentProvider>(context, listen: false).setSelectedNumberOfChair = null;

            var d = Provider.of<AppointmentProvider>(context, listen: false).getDate;
            var s = Provider.of<SalonProvider>(context, listen: false).getSalonId;
            var c = Provider.of<AppointmentProvider>(context, listen: false).getSelectedNumberOfChair;

            Provider.of<AppointmentProvider>(context, listen: false).getSelectedNumberOfChair != null
                ? Provider.of<SlotProvider>(context, listen: false)
                    .getSlotsFunc(date: d, salonId: s.toString(), chairNumber: c.toString())
                    .then((val) {
                    loading = false;
                  })
                : Provider.of<SlotProvider>(context, listen: false)
                    .getSlotsFunc(date: d, salonId: s.toString())
                    .then((val) {
                    loading = false;
                  });
          },
          // child: Container(
          //   margin: EdgeInsets.all(10),
          //   color: Colors.red,
          //   height: 45,
          //   width: 45,
          //   child: Text(Provider.of<AppointmentProvider>(context).getNumberOfChairs.toString()),
          // ),
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: SvgPicture.asset(
              Provider.of<AppointmentProvider>(context, listen: false).getSelectedNumberOfChair != index + 1
                  ? 'assets/chairs/chair_outlined.svg'
                  : 'assets/chairs/chair_filled.svg',
              width: 60,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );

    var viewForAll = ElevatedButton(
      onPressed: () {
        Provider.of<AppointmentProvider>(context, listen: false).unSelectedChair();
      },
      child: Text('Clear Selection'),
    );

    var appointmentButton = GestureDetector(
      onTap: () async {
        if (Provider.of<SalonProvider>(context, listen: false).subtotal > 0 &&
            selectedSlotId != null &&
            Provider.of<SalonProvider>(context, listen: false).getServices.length > 0) {
          await AppointmentRepo()
              .bookAppointment(
            services: Provider.of<SalonProvider>(context, listen: false).getServices,
            userId: Provider.of<UserProvider>(context, listen: false).cuser.emailAddress,
            salonId: Provider.of<SalonProvider>(context, listen: false).getSalonId,
            chairNumber: Provider.of<SlotProvider>(context, listen: false).getChairNoBySlot.toString(),
            dateOfAppointment: Provider.of<AppointmentProvider>(context, listen: false).getDate,
            totalPrice: Provider.of<SalonProvider>(context, listen: false).subtotal.toString(),
            // slotId: int.parse(Provider.of<SlotProvider>(context, listen: false).getSelectedSlot),
            slotId: selectedSlotId,
          )
              .then((val) {
            return showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Congragulations! You are on the way to be fashionable."),
                actions: [
                  TextButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ > 2);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          });
        } else {
          if (Provider.of<SalonProvider>(context, listen: false).subtotal <= 0 ||
              Provider.of<SalonProvider>(context, listen: false).getServices.length <= 0) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Empty Cart"),
                content: Text("Opps... Looks like your cart is empty. Go back and add few services."),
                actions: [
                  TextButton(
                    onPressed: () {
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ > 1);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          } else if (selectedSlotId == null) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("No Time Slot Selected"),
                content: Text("Oops... Looks like you forgot to select time. Go back and select the time slot."),
                actions: [
                  TextButton(
                    onPressed: () {
                      int count = 1;
                      Navigator.of(context).popUntil((_) => count++ > 1);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: (Provider.of<SalonProvider>(context, listen: false).subtotal > 0 &&
                    selectedSlotId != null &&
                    Provider.of<SalonProvider>(context, listen: false).getServices.length > 0)
                ? Theme.of(context).primaryColor
                : Colors.grey),
        child: Text(
          'Book Appointment',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );

    var selectedServicesHeading = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Text(
        'Selected Services',
        style: TextStyle(fontSize: 20),
      ),
    );

    var calendarHeading = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Text(
        'Choose Date and time',
        style: TextStyle(fontSize: 20),
      ),
    );

    var chairHeading = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Text(
        'Select your preferred chair',
        style: TextStyle(fontSize: 18),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            selectedServicesHeading,
            servicesListView,
            // subtotal,
            calendarHeading,
            calendar,
            chairHeading,
            chairs,
            loading == false
                ? getSlots
                : Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: CustomProgressIndicator(
                      text: 'searching time slots...',
                      marginBottom: 15,
                    ),
                  ),
            // appointmentButton,
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Made with '),
                      Icon(
                        LineIcons.heartAlt,
                        size: 20,
                        color: Colors.red,
                      ),
                    ],
                  ),
                  Text('For all the fashionable people.'),
                  SizedBox(height: 30)
                ],
              ),
            ),
            SizedBox(height: 70)
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        builder: (context) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(0, -2),
                  blurRadius: 4,
                ),
              ],
            ),
            margin: EdgeInsets.all(0),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Align(
                        alignment: Alignment(-.1, 0),
                        child: Text(
                          'Total',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        ),
                      ),
                    ),
                    subtotal
                  ],
                ),
                Container(width: MediaQuery.of(context).size.width / 2, child: appointmentButton),
              ],
            )),
      ),
    );
  }
}
