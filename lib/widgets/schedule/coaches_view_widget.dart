import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/functions.dart';
import '../../providers/coach_provider.dart';
import '../../providers/reservation_provider.dart';
import '../form_dialog_widget.dart';
import 'mouse_region_widget.dart';

class CoachesViewWidget extends ConsumerStatefulWidget {
  const CoachesViewWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CoachesViewWidgetState();
}

class _CoachesViewWidgetState extends ConsumerState<CoachesViewWidget> {
  final calendarController = CalendarController();


  @override
  Widget build(BuildContext context) => MouseRegionWidget(
        controller: calendarController,
        child: SfCalendar(
          showDatePickerButton: true,
          controller: calendarController,
          view: CalendarView.timelineWeek,
          dataSource: _addResources(),
          onTap: _onCoachesViewTap,
        ),
      );

  void _onCoachesViewTap(CalendarTapDetails details) {
        if (details.targetElement == CalendarElement.calendarCell) {
      final dateTime = details.date;
      final coachId = details.resource?.id;
      print('coach view coachId---> $coachId');
      buildDialog(
        context,
        child: FormDialogWidget(
          dateTime: dateTime,
          coachId: coachId,

          // courtNumber: ref.watch(courtProvider).selectedCourtId,
          courtNumber: ref.watch(courtProvider).selectedCourtNumber,
        ),

      );
    }
  }

  _CalenderResource _addResources() {
    final appointments = ref
        .watch(reservationProvider)
        .reservationsByClubId
        .map(
          (reservation) => Appointment(
              startTime: reservation.startTime,
              endTime: reservation.endTime,
              color: kPrimaryColor,
              startTimeZone: '',
              endTimeZone: '',
              subject: reservation.title,
              resourceIds: [reservation.coachId!]),
        )
        .toList();

    final employeeCollection = ref
        .watch(coachProvider)
        .coachesByClubId
        .map(
          (coach) => CalendarResource(
            color: kPrimaryColor,
            displayName: coach.name,
            id: coach.id,
            image: NetworkImage(coach.image),
          ),
        )
        .toList();
    return _CalenderResource(employeeCollection, appointments);
  }
}

class _CalenderResource extends CalendarDataSource {
  _CalenderResource(
      List<CalendarResource> resourceColl, List<Appointment> source) {
    resources = resourceColl;
    appointments = source;
  }
}
