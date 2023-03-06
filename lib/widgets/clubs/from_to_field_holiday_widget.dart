import 'package:clients_digcoach/utils/utils.dart';
import 'package:clients_digcoach/widgets/bordered_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../models/club/holiday.dart';

class FromToHolidaysWidget extends StatefulWidget {
  const FromToHolidaysWidget({
    super.key,
    required this.holiday,
    required this.onDelete,
  });

  final Holiday holiday;
  final VoidCallback onDelete;

  @override
  State<FromToHolidaysWidget> createState() => _FromToHolidaysWidgetState();
}

class _FromToHolidaysWidgetState extends State<FromToHolidaysWidget> {
  late DateTime start;
  late DateTime end;

  @override
  void initState() {
    super.initState();

    start = widget.holiday.from;
    end = widget.holiday.to;
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('From', style: style),
            const SizedBox(height: 10),
            BorderedFieldWidget(
              text: Utils.toDateYYMMDD(start),
              onTap: showDateRangePickerDialog,
            ),
            const SizedBox(height: 10),
            BorderedFieldWidget(
              text: Utils.toTimeHm(start),
              onTap: showStartTimePickerDialog,
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('To', style: style),
            const SizedBox(height: 10),
            BorderedFieldWidget(
              text: Utils.toDateYYMMDD(end),
              onTap: () => showDateRangePickerDialog(isStart: false),
            ),
            const SizedBox(height: 10),
            BorderedFieldWidget(
              text: Utils.toTimeHm(end),
              onTap: showEndTimePickerDialog,
            ),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          margin: const EdgeInsets.only(top: 24),
          child: IconButton(
            onPressed: widget.onDelete,
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ],
    );
  }

  void showDateRangePickerDialog({bool isStart = true}) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400, maxHeight: 300),
            child: SfDateRangePicker(
              backgroundColor: Colors.white,
              selectionMode: DateRangePickerSelectionMode.extendableRange,
              onSelectionChanged: (args) {
                if (args.value is PickerDateRange) {
                  final newStart = args.value.startDate;
                  final newEnd = args.value.endDate;

                  setState(() {
                    start = DateTime(
                      newStart.year,
                      newStart.month,
                      newStart.day,
                      start.hour,
                      start.minute,
                    );
                    end = DateTime(
                      newEnd.year,
                      newEnd.month,
                      newEnd.day,
                      end.hour,
                      end.minute,
                    );
                  });
                }
              },
              monthViewSettings: const DateRangePickerMonthViewSettings(
                enableSwipeSelection: false,
              ),
              extendableRangeSelectionDirection: isStart
                  ? ExtendableRangeSelectionDirection.backward
                  : ExtendableRangeSelectionDirection.forward,
              initialDisplayDate: widget.holiday.from,
              initialSelectedRange: PickerDateRange(start, end),
            ),
          ),
        );
      },
    );
  }

  Future<void> showStartTimePickerDialog() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: start.hour, minute: start.minute),
    );
    if (time == null) return;

    setState(() {
      start = DateTime(
        start.year,
        start.month,
        start.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> showEndTimePickerDialog() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: end.hour, minute: end.minute),
    );
    if (time == null) return;

    setState(() {
      end = DateTime(
        end.year,
        end.month,
        end.day,
        time.hour,
        time.minute,
      );
    });
  }
}
