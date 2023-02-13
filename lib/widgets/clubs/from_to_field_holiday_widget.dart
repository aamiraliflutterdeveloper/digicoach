import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils.dart';
import '../../models/holiday.dart';
import '../text_form_field_widget.dart';

class FromToHolidaysWidget extends StatefulWidget {
  const FromToHolidaysWidget({
    super.key,
    required this.holiday,
    this.onDelete,
  });

  final Holiday holiday;
  final VoidCallback? onDelete;

  @override
  State<FromToHolidaysWidget> createState() => _FromToHolidaysWidgetState();
}

class _FromToHolidaysWidgetState extends State<FromToHolidaysWidget> {
  TextEditingController holidayFrom = TextEditingController();
  TextEditingController holidayTo = TextEditingController();

  @override
  void initState() {
    super.initState();
    holidayFrom.text = Utils.toDateYYMMDD(widget.holiday.holidaysFrom);
    holidayTo.text = Utils.toDateYYMMDD(widget.holiday.holidaysTo);
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('From', style: style),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: TextFormFieldWidget(
                controller: holidayFrom,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DateTextFormatter(),
                ],
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
              child: TextFormFieldWidget(
                controller: holidayTo,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  DateTextFormatter(),
                ],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: widget.onDelete,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '-');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 3 || i == 5) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) =>
      TextSelection.fromPosition(TextPosition(offset: text.length));
}
