import 'package:clients_digcoach/core/responsive.dart';
import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:clients_digcoach/widgets/schedule/mouse_region_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/functions.dart';
import '../../providers/coach_provider.dart';
import '../../providers/reservation_provider.dart';
import '../form_dialog_widget.dart';

class DayViewWidget extends ConsumerStatefulWidget {
  const DayViewWidget({super.key, required this.isCoachView});

  final bool isCoachView;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DayViewWidgetState();
}

class _DayViewWidgetState extends ConsumerState<DayViewWidget> {
  final _controller = CalendarController();
  final formKey = GlobalKey<FormState>();
  int currentPage = 0;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ref.watch(reservationProvider).isLoading
        ? const Expanded(
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  top: -height / 8,
                  child: buildDayViewCalendar(),
                ),
                Positioned.fill(bottom: height / 2, child: buildCourts()),
                Positioned.fill(
                  bottom: (height / 1.5),
                  child: buildCourtsArrow(),
                ),
              ],
            ),
          );
  }

  Widget buildDayViewCalendar() => MouseRegionWidget(
        controller: _controller,
        child: SfCalendar(
          headerDateFormat: 'MMM d, yyyy',
          headerHeight: 230,
          viewHeaderHeight: 0,
          view: CalendarView.workWeek,
          controller: _controller,
          timeSlotViewSettings: const TimeSlotViewSettings(
              timeInterval: Duration(minutes: 30), timeFormat: 'h:mm'),
          dataSource: widget.isCoachView
              ? _getCoachesCalendarDataSource()
              : _getCourtsCalendarDataSource(),
          showDatePickerButton: true,
          showNavigationArrow: false,
          allowViewNavigation: true,
          allowDragAndDrop: true,
          onTap: _onTap,
        ),
      );

  void _onTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      final dateTime = details.date;
      final coachId = details.resource?.id;
      print('day ---> $coachId');
      final courtNumber = _controller.selectedDate!
              .difference(_controller.displayDate!)
              .inDays +
          1;
      print('courtNumber ---> $courtNumber');

      buildDialog(
        context,
        child: FormDialogWidget(
          dateTime: dateTime,
          courtNumber: courtNumber,
          coachId: '$coachId',
        ),
      );
    }
  }

  Widget buildCourts() {
    final responsive = Responsive();
    responsive.init(context);
    final width = responsive.screenWidth;
    final courts = ref.watch(courtProvider).courtsByClubId;
    return Row(
      children: [
        if (responsive.isMobile) const SizedBox(width: 30),
        SizedBox(width: width / 12),
        Expanded(
          child: SizedBox(
            height: 50,
            child: PageView.builder(
              itemCount: courtLength,
              scrollDirection: Axis.horizontal,
              controller: pageController,
              onPageChanged: (value) => setState(() => currentPage = value),
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  courts.length > 5 ? 5 : courts.length,
                  (i) => Text(
                    courts[index + i].name,
                    style: const TextStyle(
                      fontSize: 16,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: width / 24),
      ],
    );
  }

  Widget buildCourtsArrow() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 50),
          currentPage.round() == 0
              ? const SizedBox()
              : IconButton(
                  onPressed: previousPage,
                  icon: const Icon(Icons.arrow_back_ios),
                ),
          currentPage.round() == courtLength - 1
              ? const SizedBox()
              : IconButton(
                  onPressed: nextPage,
                  icon: const Icon(Icons.arrow_forward_ios),
                ),
        ],
      );

  int get courtLength {
    final courts = ref.watch(courtProvider).courtsByClubId;
    return courts.length > 5 ? courts.length - 4 : 1;
  }

  void nextPage() {
    pageController.animateToPage(currentPage.round() + 5,
        duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
    _controller.forward!();
  }

  void previousPage() {
    pageController.animateToPage(currentPage.round() - 5,
        duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
    _controller.backward!();
  }

  DayAppointmentDataSource _getCoachesCalendarDataSource() {
    final appointments = ref
        .watch(reservationProvider)
        .reservationsByCoachId
        .map((e) => Appointment(
              startTime: e.startTime,
              endTime: e.endTime,
              color: kPrimaryColor,
              subject: e.title,
            ))
        .toList();

    return DayAppointmentDataSource(appointments);
  }

  DayAppointmentDataSource _getCourtsCalendarDataSource() {
    final appointments = ref
        .watch(reservationProvider)
        .reservationsByCourtNumber
        .map((e) => Appointment(
              startTime: e.startTime,
              endTime: e.endTime,
              color: kPrimaryColor,
              subject: e.title,
            ))
        .toList();

    return DayAppointmentDataSource(appointments);
  }
}

class DayAppointmentDataSource extends CalendarDataSource {
  DayAppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
