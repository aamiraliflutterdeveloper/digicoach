import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/constants.dart';
import '../../../services/club_service.dart';

class HeatMapWidget extends ConsumerStatefulWidget {
  const HeatMapWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeatMapWidgetState();
}

class _HeatMapWidgetState extends ConsumerState<HeatMapWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SfCalendar(
            view: CalendarView.month,
            showDatePickerButton: true,
            showNavigationArrow: true,
            monthCellBuilder: _monthCellBuilder,
            monthViewSettings: const MonthViewSettings(
              showTrailingAndLeadingDates: false,
            ),
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
        .watch(clubServiceProvider)
        .clubs[0]
        .reservations
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
  Color _getCellTextColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5
        ? Colors.black54
        : Colors.white;
  }
}
