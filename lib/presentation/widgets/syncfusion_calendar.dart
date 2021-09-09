import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SyncFusionCalendar extends StatelessWidget {
  const SyncFusionCalendar({
    Key? key,
    required CalendarController calendarController,
    required this.onSelectionChanged,
  })  : _calendarController = calendarController,
        super(key: key);

  final CalendarController _calendarController;
  final Function(CalendarSelectionDetails date) onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: SfCalendar(
        minDate: DateTime.now(),
        maxDate: DateTime.now().add(Duration(days: 7)),
        firstDayOfWeek: DateTime.now().weekday,
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
        controller: _calendarController,
        monthCellBuilder: (context, MonthCellDetails details) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Text(details.date.day.toString()),
          );
        },
        onSelectionChanged: onSelectionChanged,
        monthViewSettings: MonthViewSettings(
          showTrailingAndLeadingDates: false,
          navigationDirection: MonthNavigationDirection.horizontal,
          numberOfWeeksInView: 1,
          dayFormat: 'EEE',
        ),
      ),
    );
  }
}

//  var fullDate;
//             var day = date.date!.day;
//             var month = date.date!.month;
//             var year = date.date!.year;

//             if (month < 10 && day < 10) {
//               fullDate = '$year-0$month-0$day';
//             } else if (month >= 10 && day < 10) {
//               fullDate = '$year-$month-0$day';
//             } else if (month < 10 && day >= 10) {
//               fullDate = '$year-0$month-$day';
//             } else if (month >= 10 && day >= 10) {
//               fullDate = '$year-$month-$day';
//             } else
//               throw RangeError;
//             print("Full Date from inside the calendar - ");
//             // Provider.of<AppointmentProvider>(context, listen: false).setDate = fullDate;