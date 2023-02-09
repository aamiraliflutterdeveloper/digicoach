import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:clients_digcoach/widgets/schedule/mouse_region_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/functions.dart';
import '../../providers/reservation_provider.dart';
import '../form_dialog_widget.dart';

class WeekViewWidget extends ConsumerStatefulWidget {
  const WeekViewWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends ConsumerState<WeekViewWidget> {
  final calendarController = CalendarController();

  @override
  Widget build(BuildContext context) => MouseRegionWidget(
        controller: calendarController,
        child: SfCalendar(
          view: CalendarView.week,
          dataSource: _getCalendarDataSource(),
          controller: calendarController,
          showDatePickerButton: true,
          showNavigationArrow: true,
          allowAppointmentResize: true,
          allowViewNavigation: true,
          onTap: (details) {
            if (details.targetElement == CalendarElement.calendarCell) {
              final dateTime = details.date;
              final coachId = details.resource?.id;
              print('week coachId---> $coachId');

              // if (ref.watch(courtProvider).selectedCourtId != null) {
              if (ref.watch(courtProvider).selectedCourtNumber != null) {
                buildDialog(
                  context,
                  child: FormDialogWidget(
                    dateTime: dateTime,
                    coachId: coachId,
                    // courtNumber: ref.watch(courtProvider).selectedCourtId,
                    courtNumber: ref.watch(courtProvider).selectedCourtNumber,
                  ),
                );
              } else {
                buildDialog(context, child: Text('Select Court First'));
              }
            }
          },
        ),
      );

  List<Appointment> appointments = [];

  CustomDataSource _getCalendarDataSource() {
    // if (ref.watch(courtProvider).selectedCourtId != null) {
    if (ref.watch(courtProvider).selectedCourtNumber != null) {
      appointments = ref
          .watch(reservationProvider)
          .reservationsByCourtNumber
          .map((e) => Appointment(
                startTime: e.startTime,
                endTime: e.endTime,
                color: kPrimaryColor,
                subject: e.title,
              ))
          .toList();
    }
    return CustomDataSource(appointments);
  }
}

class CustomDataSource extends CalendarDataSource {
  CustomDataSource(List<Appointment> source) {
    appointments = source;
  }
}
