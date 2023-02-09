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
  const DayViewWidget({super.key});

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
   // return MouseRegionWidget(
   //    controller: _controller,
   //    child: SfCalendar(
   //      showDatePickerButton: true,
   //      controller: _controller,
   //      view: CalendarView.timelineWeek,
   //      dataSource: _addResources(),
   //      onTap: ( details) {
   //        if (details.targetElement == CalendarElement.calendarCell) {
   //          final dateTime = details.date;
   //          final coachId = details.resource?.id;
   //
   //          buildDialog(
   //            context,
   //            child: FormDialogWidget(
   //              dateTime: dateTime,
   //              coachId: coachId,
   //              courtNumber: ref.watch(courtProvider).selectedCourtId,
   //            ),
   //
   //          );
   //        }
   //      },
   //    ),
   //  );
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          top: -height / 8,
          child: buildDayViewCalendar(),
        ),
        Positioned.fill(
          bottom: height / 1.7,
          child: buildCourts(),
        ),
        Positioned.fill(
          bottom: (height / 1.3),
          child: buildCourtsArrow(),
        ),
      ],
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
          dataSource: _getCalendarDataSource(),
          showDatePickerButton: true,
          showNavigationArrow: true,
          allowAppointmentResize: true,
          allowViewNavigation: true,
          onTap: (details) {
            if (details.targetElement == CalendarElement.calendarCell) {
              final dateTime = details.date;
              final coachId = details.resource?.id;
              print('day ---> $coachId');
              final courtNumber = _controller.selectedDate!.difference(_controller.displayDate!).inDays+1;
              buildDialog(
                context,
                child: FormDialogWidget(
                  dateTime: dateTime,
                  courtNumber: courtNumber.toString(),
                  coachId: coachId,
                ),
              );
            }
          },
        ),
      );

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
          currentPage.round() == 0 ? const SizedBox() : IconButton(
            onPressed: previousPage,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          currentPage.round() == courtLength - 1 ? const SizedBox() :     IconButton(
            onPressed: nextPage,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      );

  int get courtLength {
    final courts = ref.watch(courtProvider).courtsByClubId;
    return courts.length > 5 ? courts.length - 4 : 1;
  }

  void previousPage() => pageController.animateToPage(currentPage.round() - 5,
      duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);

  void nextPage() => pageController.animateToPage(currentPage.round() + 5,
      duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);

  DayAppointmentDataSource _getCalendarDataSource() {
    final appointments = ref
        .watch(reservationProvider)
        .reservationsByClubId
        .map((e) => Appointment(
              startTime: e.startTime,
              endTime: e.endTime,
              color: kPrimaryColor,
              subject: e.title,
            ))
        .toList();

    return DayAppointmentDataSource(appointments);
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

class DayAppointmentDataSource extends CalendarDataSource {
  DayAppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
class _CalenderResource extends CalendarDataSource {
  _CalenderResource(
      List<CalendarResource> resourceColl, List<Appointment> source) {
    resources = resourceColl;
    appointments = source;
  }
}