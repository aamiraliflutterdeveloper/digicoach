import 'package:clients_digcoach/models/club/opening_time.dart';
import 'package:clients_digcoach/utils/utils.dart';
import 'package:clients_digcoach/widgets/dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../text_form_field_widget.dart';

class FromToWidget extends StatefulWidget {
  const FromToWidget({
    super.key,
    required this.time,
    required this.onDelete,
    required this.onChanged,
  });

  final OpeningTime time;
  final VoidCallback onDelete;
  final ValueChanged<OpeningTime> onChanged;

  @override
  State<FromToWidget> createState() => _FromToWidgetState();
}

class _FromToWidgetState extends State<FromToWidget> {
  final times = List.generate(24 * 2, (index) {
    final hours = index ~/ 2;
    final minutes = index % 2 == 0 ? 0 : 30;

    return Utils.time(hours, minutes);
  });

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    final from = widget.time.from;
    final to = widget.time.to;

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('From', style: style),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: DropdownFieldWidget(
                items: times,
                value: from,
                onChanged: (from) {
                  final newTime = widget.time.copy(from: from);

                  widget.onChanged(newTime);
                },
                //validator: (value) => fromValidator(endDate, value!),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('To', style: style),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: DropdownFieldWidget(
                items: times,
                value: to,
                onChanged: (to) {
                  final newTime = widget.time.copy(to: to);

                  widget.onChanged(newTime);
                },
                //validator: (value) => toValidator(startDate, value!),
              ),
            ),
          ],
        ),
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

  String? fromValidator(String toValue, String fromValue) {
    if (int.parse(fromValue.split(':').first) <
        int.parse(toValue.split(':').first)) {
      return null;
    }

    return null;
  }

  String? toValidator(String toValue, String fromValue) {
    if (int.parse(toValue.split(':').first) <
        int.parse(fromValue.split(':').first)) {
      return 'choose an end time later than the start time';
    }
    return null;
  }
}
