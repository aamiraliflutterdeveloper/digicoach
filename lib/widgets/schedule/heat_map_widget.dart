import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/constants/colors.dart';
import '../../providers/schedule_provider.dart';

class HeatMapWidget extends ConsumerStatefulWidget {
  const HeatMapWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeatMapWidgetState();
}

class _HeatMapWidgetState extends ConsumerState<HeatMapWidget> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
           Expanded(
          child: SfCalendar(
            view: CalendarView.month,
            showDatePickerButton: true,
            showNavigationArrow: true,
            monthViewSettings: const MonthViewSettings(
              showTrailingAndLeadingDates: false,
            ),
            monthCellBuilder: _monthCellBuilder,
            allowAppointmentResize: true,
            allowViewNavigation: true,
            onTap: (details) {
              if (details.targetElement == CalendarElement.appointment ||
                  details.targetElement == CalendarElement.calendarCell) {
                ref.watch(scheduleProvider).currentIndex = 1;
              }
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          height: 70,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text('Less'),
                    Text('More'),
                  ],
                ),
                Container(
                  height: 20,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        kLightGrey,
                        kLightGreen,
                        kMidGreen,
                        kDarkGreen,
                        kDarkerGreen,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  /// Returns the builder for month cell.
  Widget _monthCellBuilder(
      BuildContext buildContext, MonthCellDetails details) {
    final Color backgroundColor = _getMonthCellBackgroundColor(details.date);
    final Color defaultColor = backgroundColor.computeLuminance() > 0.5
        ? Colors.black54
        : Colors.white;
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: defaultColor, width: 0.5)),
      child: Center(
        child: Text(
          details.date.day.toString(),
          style: TextStyle(color: _getCellTextColor(backgroundColor)),
        ),
      ),
    );
  }

  /// Returns the cell background color based on the date
  Color _getMonthCellBackgroundColor(DateTime date) {
    final int reservationCount = ref
        .watch(reservationProvider)
        .reservationsByClubId
        .where((reservation) =>
            reservation.startTime.day == date.day &&
            reservation.startTime.month == date.month &&
            reservation.startTime.year == date.year)
        .length;

    if (reservationCount == 0) {
      return kLightGrey;
    } else if (reservationCount > 0 && reservationCount <= 2) {
      return kLightGreen;
    } else if (reservationCount > 2 && reservationCount <= 4) {
      return kMidGreen;
    } else if (reservationCount > 4 && reservationCount <= 6) {
      return kDarkGreen;
    } else {
      return kDarkerGreen;
    }
  }

  /// Returns the cell  text color based on the cell background color
  Color _getCellTextColor(Color backgroundColor) =>
      backgroundColor.computeLuminance() > 0.5 ? Colors.black54 : Colors.white;
}
