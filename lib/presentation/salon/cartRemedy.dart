import 'package:cara_app/data/models/salon/service.dart';
import 'package:cara_app/data/models/slot.dart';
import 'package:cara_app/data/repositories/appointment_repo.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CartRemedy extends StatefulWidget {
  const CartRemedy({Key? key, required this.salonId, required this.userId, required this.services}) : super(key: key);

  final String salonId;
  final String userId;
  final List<Service> services;

  @override
  _CartRemedyState createState() => _CartRemedyState();
}

class _CartRemedyState extends State<CartRemedy> {
  CalendarController _calendarController = CalendarController();

  var fullDate = '2021-09-07';
  var slotId;
  var selectedSlot, selectedSlotId;

  List<Slot> slots = [];

  getSlots() async {
    var data = await AppointmentRepo().getSlots(date: fullDate, salonId: widget.salonId);

    return data;
  }

  @override
  void initState() {
    getSlots().then((data) {
      slots = data;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Text(widget.salonId),
                Text(widget.userId),
                Text(widget.services.length.toString()),
                Container(
                    height: 150,
                    child: SfCalendar(
                      minDate: DateTime.now(),
                      maxDate: DateTime.now().add(Duration(days: 10)),
                      firstDayOfWeek: 1,
                      view: CalendarView.month,
                      viewHeaderHeight: 40,
                      headerHeight: 50,
                      initialDisplayDate: DateTime.now(),
                      initialSelectedDate: DateTime.now(),
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
                      onSelectionChanged: (date) async {
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
                        setState(() {});
                        getSlots().then((data) {
                          setState(() {
                            slots = data;
                          });
                        });
                        // Provider.of<AppointmentProvider>(context, listen: false).setDate = fullDate;
                      },
                      monthViewSettings: MonthViewSettings(
                        showTrailingAndLeadingDates: false,
                        navigationDirection: MonthNavigationDirection.horizontal,
                        numberOfWeeksInView: 1,
                        dayFormat: 'EEE',
                      ),
                    )),
                Text(fullDate),
                // FutureBuilder(
                //     future: AppointmentRepo().getSlots(date: fullDate, salonId: widget.salonId),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                //         List<Slot> slots = snapshot.data as List<Slot>;
                //         return Container(
                //           height: 300,
                //           child: GridView.builder(
                //             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                //             physics: NeverScrollableScrollPhysics(),
                //             shrinkWrap: true,
                //             itemCount: slots.length,
                //             itemBuilder: (context, index) => InkWell(
                //               onTap: () {
                //                 setState(() {
                //                   selectedSlot = index;
                //                   selectedSlotId = slots[index].slotId;
                //                 });
                //                 print(selectedSlotId);
                //               },
                //               child: Container(
                //                 alignment: Alignment.center,
                //                 decoration: BoxDecoration(
                //                     color: selectedSlot == index ? Colors.red.withOpacity(.4) : Colors.white,
                //                     borderRadius: BorderRadius.circular(5),
                //                     boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]),
                //                 margin: EdgeInsets.all(10),
                //                 child: Text(
                //                   slots[index].startTime.toString(),
                //                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                //                 ),
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
                //     }),
                // Text(slotId.toString()),
                slots.length > 0
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: slots.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedSlot = index;
                              selectedSlotId = slots[index].slotId;
                            });
                            print(selectedSlotId);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: selectedSlot == index ? Colors.red.withOpacity(.4) : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]),
                            margin: EdgeInsets.all(10),
                            child: Text(
                              slots[index].startTime.toString(),
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    : Text('No data available'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
