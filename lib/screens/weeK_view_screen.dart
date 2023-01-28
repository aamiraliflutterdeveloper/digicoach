import 'package:clients_digcoach/models/reservation.dart';
import 'package:clients_digcoach/services/reservation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../core/utils.dart';

class WeekViewScreen extends ConsumerStatefulWidget {
  const WeekViewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeekViewScreenState();
}

class _WeekViewScreenState extends ConsumerState<WeekViewScreen> {
  @override
  void initState() {
    super.initState();
    _fetchCourts();
  }

  void _fetchCourts() async {
    await ref.read(reservationProvider.notifier).getReservations();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ref.read(reservationProvider.notifier).getReservations(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Court',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: ref.watch(reservationProvider).selectedCourt,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                    underline: Container(color: Colors.transparent),
                    onChanged: (String? newValue) {
                      ref.read(reservationProvider.notifier).setSelectedCourt =
                          newValue!;
                    },
                    items: ref
                        .watch(reservationProvider)
                        .reservations
                        .map((e) => e.courtId)
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              Expanded(
                child: WeekViewWidget(),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}

class WeekViewWidget extends ConsumerWidget {
  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now().add(const Duration(hours: 2));
  bool isAllDay = false;
  String? selectedCourt;
  String? selectedCoach;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCourt = ref.watch(reservationProvider).selectedCourt;

    final reservations = ref.watch(reservationProvider).reservations;

    final appointments = reservations
        .where((element) => element.clubId == selectedCourt.toString())
        .map((e) => Appointment(
              startTime: e.startTime,
              endTime: e.endTime,
              color: Colors.blue,
            ))
        .toList();
    return SfCalendar(
      view: CalendarView.week,
      showNavigationArrow: true,
      allowViewNavigation: true,
      dataSource: CustomDataSource(appointments),
      onTap: (CalendarTapDetails details) {
        buildEditingPopUp(context);
      },
    );
  }

  Future<void> buildEditingPopUp(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(context: context),
              const SizedBox(height: 12),
              buildDateTimePickers(context: context),
              const SizedBox(height: 12),
              buildDescription(context: context),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => saveForm(context: context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  List<Widget> buildEditingActions({required BuildContext context}) => [];

  Widget buildTitle({required BuildContext context}) => TextFormField(
        style: const TextStyle(fontSize: 24),
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'Add Title',
        ),
        onFieldSubmitted: (_) => saveForm(context: context),
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty' : null,
        controller: titleController,
      );

  Widget buildDescription({required BuildContext context}) => TextFormField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Add Details',
        ),
        textInputAction: TextInputAction.newline,
        maxLines: 5,
        onFieldSubmitted: (_) => saveForm(context: context),
        controller: descriptionController,
      );

  Widget buildDateTimePickers({required BuildContext context}) => Column(
        children: [
          buildFrom(context: context),
          if (!isAllDay) buildTo(context: context),
          StatefulBuilder(builder: (context, setState) {
            return CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              title: const Text('All Day booking'),
              value: isAllDay,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => setState(() => isAllDay = value!),
            );
          })
        ],
      );

  Widget buildFrom({required BuildContext context}) => buildHeader(
        header: 'FROM',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () =>
                    pickFromDateTime(pickDate: true, context: context),
              ),
            ),
            if (!isAllDay)
              Expanded(
                child: buildDropdownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () =>
                      pickFromDateTime(pickDate: false, context: context),
                ),
              ),
          ],
        ),
      );

  Widget buildTo({required BuildContext context}) => buildHeader(
        header: 'TO',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () =>
                    pickToDateTime(pickDate: true, context: context),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () =>
                    pickToDateTime(pickDate: false, context: context),
              ),
            ),
          ],
        ),
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(header, style: const TextStyle(fontWeight: FontWeight.bold)),
            child,
          ],
        ),
      );

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  Future pickFromDateTime(
      {required bool pickDate, required BuildContext context}) async {
    final date =
        await pickDateTime(fromDate, pickDate: pickDate, context: context);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }

    // setState(() => fromDate = date);
  }

  Future pickToDateTime(
      {required bool pickDate, required BuildContext context}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
      context: context,
    );
    if (date == null) return;

    // setState(() => toDate = date
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
    required BuildContext context,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  Future saveForm({required BuildContext context}) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      Navigator.of(context).pop();
    }
  }
}

class CustomDataSource extends CalendarDataSource {
  CustomDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class BookingDataSource extends CalendarDataSource {
  BookingDataSource(List<Reservation> appointments) {
    this.appointments = appointments;
  }
}
