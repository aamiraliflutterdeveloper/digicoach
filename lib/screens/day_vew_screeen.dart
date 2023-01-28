import 'package:clients_digcoach/services/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/reservation.dart';
import '../services/court_service.dart';

class DayViewScreen extends ConsumerStatefulWidget {
  const DayViewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DayViewScreenState();
}

class _DayViewScreenState extends ConsumerState<DayViewScreen> {
  @override
  void initState() {
    super.initState();
    _fetchCourts();
  }

  void _fetchCourts() async {
    await ref.read(courtServiceProvider.notifier).getCourtsByClubId('1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.read(courtServiceProvider.notifier).getCourtsByClubId('1'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DayViewWidget();
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}

class DayViewWidget extends ConsumerWidget {
  DayViewWidget({super.key});

  final _controller = CalendarController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.read(reservationProvider.notifier).getReservations(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return SfCalendar(
          view: CalendarView.day,
          controller: _controller,
          dataSource: _getCalendarDataSource(
            ref.read(reservationProvider.notifier).reservations,
          ),
          timeSlotViewSettings: const TimeSlotViewSettings(
            timeInterval: Duration(minutes: 30),
            timeIntervalHeight: 50,
          ),
        );
      },
    );
  }

  _getCalendarDataSource(List<Reservation> reservations) {
    List<Appointment> appointments = <Appointment>[];
    for (var reservation in reservations) {
      appointments.add(Appointment(
        startTime: reservation.startTime,
        endTime: reservation.endTime,
        color: Colors.blue,
        startTimeZone: '',
        endTimeZone: '',
      ));
    }

    return _AppointmentDataSource(appointments);
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
