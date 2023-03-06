import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:clients_digcoach/utils/widget_utils.dart';
import 'package:clients_digcoach/widgets/schedule/mouse_region_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../providers/reservation_provider.dart';
import '../drop_down_widget.dart';
import '../form_dialog_widget.dart';

class WeekViewWidget extends ConsumerStatefulWidget {
  const WeekViewWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends ConsumerState<WeekViewWidget> {
  final calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    final courts = ref.read(courtProvider).courtsByClubId;
    return ref.watch(reservationProvider).isLoading
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Expanded(
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  child: DropDownWidget(
                    hintText: 'Select Court',
                    currentValue: ref.watch(courtProvider).selectedCourtNumber,
                    onChanged: (value) => _onChangedCourt(value as int?),
                    values: courts.map((e) => e.courtNumber).toList(),
                    items: courts.map((e) => e.name).toList(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MouseRegionWidget(
                    controller: calendarController,
                    child: SfCalendar(
                      view: CalendarView.week,
                      firstDayOfWeek: 1,
                      allowedViews: const [
                        CalendarView.day,
                        CalendarView.week,
                        CalendarView.month,
                      ],
                      dataSource: _getCalendarDataSource(),
                      specialRegions: _getTimeRegions(),
                      controller: calendarController,
                      showDatePickerButton: true,
                      showNavigationArrow: true,
                      allowViewNavigation: true,
                      allowDragAndDrop: true,
                      timeSlotViewSettings: const TimeSlotViewSettings(
                        timeInterval: Duration(minutes: 30),
                        timeFormat: 'h:mm',
                      ),
                      onTap: _onTap,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  void _onChangedCourt(int? value) {
    ref.read(courtProvider).selectedCourtNumber = value!;
    ref.read(reservationProvider).getReservationsByCourtNumber(value);
  }

  void _onTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final dateTime = details.date;
      final coachId = details.resource?.id;
      print('week coachId---> $coachId');

      if (ref.watch(courtProvider).selectedCourtNumber != null) {
        WidgetUtils.buildDialog(
          context,
          child: FormDialogWidget(
            dateTime: dateTime,
            coachId: '$coachId',
            courtNumber: ref.watch(courtProvider).selectedCourtNumber,
          ),
        );
      } else {
        WidgetUtils.buildDialog(context,
            child: const Text('Select Court First'));
      }
    }
  }

  List<Appointment> appointments = [];

  CustomDataSource _getCalendarDataSource() {
    if (ref.watch(courtProvider).selectedCourtNumber != null) {
      appointments = ref
          .watch(reservationProvider)
          .reservationsByCourtNumber
          .map((e) => Appointment(
                startTime: e.startTime,
                endTime: e.endTime,
                color: AppColors.primaryColor,
                subject: e.title,
              ))
          .toList();
    }
    return CustomDataSource(appointments);
  }

  List<TimeRegion> _getTimeRegions() {
    final List<TimeRegion> regions = <TimeRegion>[];
    regions.add(TimeRegion(
      startTime: DateTime(2020, 5, 29, 00, 0, 0),
      endTime: DateTime(2020, 5, 29, 24, 0, 0),
      recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=SAT,SUN',
      color: const Color(0xffbd3d3d3),
    ));

    return regions;
  }
}

class CustomDataSource extends CalendarDataSource {
  CustomDataSource(List<Appointment> source) {
    appointments = source;
  }
}
