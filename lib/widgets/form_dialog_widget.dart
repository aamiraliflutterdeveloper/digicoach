import 'package:clients_digcoach/core/utils.dart';
import 'package:clients_digcoach/models/reservation.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/reservation_provider.dart';
import 'package:clients_digcoach/widgets/drop_down_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/enums/reservation_status.dart';
import '../providers/coach_provider.dart';
import '../providers/court_provider.dart';
import 'text_form_field_widget.dart';

class FormDialogWidget extends ConsumerStatefulWidget {
  const FormDialogWidget({
    super.key,
    required this.dateTime,
    this.coachId,
    this.courtNumber,
  });

  final DateTime? dateTime;
  final Object? coachId;
  final String? courtNumber;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FormDialogWidgetState();
}

class _FormDialogWidgetState extends ConsumerState<FormDialogWidget> {
  late DateTime startDateTime;
  late DateTime endDateTime;
  final formKey = GlobalKey<FormState>();
  late Object? coachId;
  late String? courtNumber;

  final descriptionController = TextEditingController();
  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startDateTime = widget.dateTime!;
    endDateTime = widget.dateTime!.add(const Duration(hours: 1));
    coachId = widget.coachId;
    courtNumber = widget.courtNumber;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final coach = ref.read(coachProvider);
    final court = ref.read(courtProvider);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormFieldWidget(
            hintText: 'Title',
            controller: titleController,
            isRequired: true,
          ),
          const SizedBox(height: 24),
          buildSelectDateTime(),
          const SizedBox(height: 24),
          const Text('Select Coach'),
          DropDownWidget(
            hint: 'Select Coach',
            currentValue: (coachId as String?),
            onChanged: (value) => setState(() => coachId = value),
            items: coach.coachesByClubId.map((e) => e.name).toList(),
            id: coach.coachesByClubId.map((e) => e.id).toList(),
          ),
          const SizedBox(height: 24),
          const Text('Select Court'),
          DropDownWidget(
            hint: 'Select Court',
            currentValue:courtNumber?? ref.watch(courtProvider).selectedCourtNumber ,
            // currentValue: ref.watch(courtProvider).selectedCourtNumber,
            // onChanged: (value) => setState(() => courtNumber = value),
            onChanged: ref.read(courtProvider).selectedCourtNumber == null
                ? (value) => setState(() => courtNumber = value)
                : (value) => setState(
                    () => ref.read(courtProvider).selectedCourtNumber = value),

            // currentValue: ref.watch(courtProvider).selectedCourtId,
            // onChanged: (value) => court.selectedCourtId = value!,
            id: court.courtsByClubId.map((e) => '${e.courtNumber}').toList(),
            items: court.courtsByClubId.map((e) => e.name).toList(),
            validator: (title) => title == null ? 'field required' : null,
          ),
          const SizedBox(height: 24),
          TextFormFieldWidget(
            hintText: 'Description',
            controller: descriptionController,
            maxLines: 5,
          ),
          const SizedBox(height: 32),
          buildDialogButtons(width),
        ],
      ),
    );
  }

  Row buildSelectDateTime() => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('start'),
                TextFormFieldWidget(
                  hintText:
                      '${Utils.toDate(startDateTime)} - ${Utils.toTime(startDateTime)}',
                  isSuffix: true,
                  dateOnPressed: () => pickStartDateTime(true),
                  timeOnPressed: () => pickStartDateTime(false),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('end'),
                TextFormFieldWidget(
                  hintText:
                      '${Utils.toDate(endDateTime)} - ${Utils.toTime(endDateTime)}',
                  isSuffix: true,
                  dateOnPressed: () => pickEndDateTime(true),
                  timeOnPressed: () => pickEndDateTime(false),
                ),
              ],
            ),
          ),
        ],
      );

  Row buildDialogButtons(double width) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(fixedSize: Size(width / 12, 30)),
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                final reservation = Reservation(
                  id: '${ref.watch(reservationProvider).reservations.length + 1}',
                  // courtId: ref.watch(courtProvider).selectedCourtId!,
                  // courtId: courtNumber.toString(),
                  // courtId:  ,
                  clubId: ref.watch(clubProvider).selectedClubId!,
                  startTime: startDateTime,
                  endTime: endDateTime,
                  status: ReservationStatus.pending,
                  title: titleController.text,
                  coachId: coachId as String? ?? '',
                  courtNumber: int.parse(
                      ref.watch(courtProvider).selectedCourtNumber ??courtNumber.toString() ),
                  // int.parse(courtNumber.toString()),
                );
                ref.read(reservationProvider).addReservation(
                      reservation,
                      reservation.clubId,
                      // int.parse(courtNumber.toString()),
                  int.parse(
                      ref.watch(courtProvider).selectedCourtNumber ??courtNumber.toString() ),
                      // reservation.courtId,
                    );
                Navigator.of(context).pop();
              }
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                fixedSize: Size(width / 12, 30)),
            child: const Text('Save'),
          ),
        ],
      );

  Future<void> pickStartDateTime(bool isDate) async {
    final date = await pickDateTime(initialDate: startDateTime, isDate: isDate);
    if (date == null) return;

    if (date.isAfter(endDateTime)) {
      endDateTime = DateTime(date.year, date.month, date.day, endDateTime.hour,
          endDateTime.minute);
    }
    setState(() => startDateTime = date);
  }

  Future<void> pickEndDateTime(bool isDate) async {
    final date = await pickDateTime(
        initialDate: endDateTime,
        isDate: isDate,
        firstDate: isDate ? startDateTime : null);
    if (date == null) return;
    setState(() => endDateTime = date);
  }

  Future<DateTime?> pickDateTime({
    required DateTime initialDate,
    required bool isDate,
    DateTime? firstDate,
  }) async {
    if (isDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2022),
        lastDate: DateTime(2100),
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

      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);

      return date.add(time);
    }
  }
}
