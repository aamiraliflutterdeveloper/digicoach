import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:clients_digcoach/providers/reservation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HeatMapWidget extends ConsumerStatefulWidget {
  const HeatMapWidget({super.key, required this.isCoachView});

  final bool isCoachView;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeatMapWidgetState();
}

class _HeatMapWidgetState extends ConsumerState<HeatMapWidget> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(reservationProvider).isLoading
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SfCalendar(
                    view: CalendarView.month,
                    firstDayOfWeek: 1,
                    showDatePickerButton: true,
                    showNavigationArrow: true,
                    monthViewSettings: const MonthViewSettings(
                      showTrailingAndLeadingDates: false,
                    ),
                    monthCellBuilder: _monthCellBuilder,
                    allowAppointmentResize: true,
                    allowViewNavigation: true,
                    onTap: (details) {
                      if (details.targetElement ==
                              CalendarElement.appointment ||
                          details.targetElement ==
                              CalendarElement.calendarCell) {
                        widget.isCoachView
                            ? ref.watch(coachProvider).coachesViewIndex
                            : ref.watch(courtProvider).courtsViewIndex = 1;
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
                                AppColors.lightGrey,
                                AppColors.lightGreen,
                                AppColors.midGreen,
                                AppColors.darkGreen,
                                AppColors.darkerGreen,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
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
    int reservation =
        widget.isCoachView ? _coachReservation(date) : _courtReservation(date);

    if (reservation == 0) {
      return AppColors.lightGrey;
    } else if (reservation > 0 && reservation <= 2) {
      return AppColors.lightGreen;
    } else if (reservation > 2 && reservation <= 4) {
      return AppColors.midGreen;
    } else if (reservation > 4 && reservation <= 6) {
      return AppColors.darkGreen;
    } else {
      return AppColors.darkerGreen;
    }
  }

  int _courtReservation(DateTime date) {
    final int courtReservation = ref
        .watch(reservationProvider)
        .reservationsByClubId
        .where((reservation) =>
            reservation.startTime.day == date.day &&
            reservation.startTime.month == date.month &&
            reservation.startTime.year == date.year)
        .length;
    return courtReservation;
  }

  int _coachReservation(DateTime date) {
    final int coachReservation = ref
        .watch(reservationProvider)
        .reservationsByCoachId
        .where((reservation) =>
            reservation.startTime.day == date.day &&
            reservation.startTime.month == date.month &&
            reservation.startTime.year == date.year)
        .length;
    return coachReservation;
  }

  /// Returns the cell  text color based on the cell background color
  Color _getCellTextColor(Color backgroundColor) =>
      backgroundColor.computeLuminance() > 0.5 ? Colors.black54 : Colors.white;
}
