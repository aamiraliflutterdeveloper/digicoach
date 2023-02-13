import 'package:clients_digcoach/core/utils.dart';
import 'package:clients_digcoach/models/opening_hours.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../text_form_field_widget.dart';

class FromToOpeningHoursWidget extends StatefulWidget {
  const FromToOpeningHoursWidget({
    super.key,
    this.onDelete,
    required this.openingHours,
  });

  final OpeningHours openingHours;
  final VoidCallback? onDelete;

  @override
  State<FromToOpeningHoursWidget> createState() => _FromToOpeningHoursWidgetState();
}

class _FromToOpeningHoursWidgetState extends State<FromToOpeningHoursWidget> {

  final times = List.generate(24 * 2, (index) {
    final evenHour = '${index / 2}';
    final oddHour = evenHour.length == 4
        ? evenHour.substring(0, 2)
        : evenHour.substring(0, 1);
    final hours = (index % 2 == 0) ? evenHour : oddHour;
    final minutes = index % 2 == 0 ? '0' : '30';
    final formattedHours = hours.padLeft(2, '0');
    final formattedMinutes = minutes.padLeft(2, '0');
    return '$formattedHours:$formattedMinutes';
  });

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
            Autocomplete(
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                } else {
                  return times
                      .where((time) => time.contains(textEditingValue.text));
                }
              },
              onSelected: (option) => debugPrint(option),
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                final fromFormat = Utils.toTimeHm(widget.openingHours.from);
                textEditingController.text = fromFormat;
                return SizedBox(
                  width: 200,
                  child: TextFormFieldWidget(
                    onEditingComplete: onFieldSubmitted,
                    focusNode: focusNode,
                    controller: textEditingController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TimeInputFormatter(),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('To', style: style),
            const SizedBox(height: 10),
            Autocomplete(
              optionsBuilder: (textEditingValue) {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                } else {
                  return times
                      .where((time) => time.contains(textEditingValue.text));
                }
              },
              onSelected: (option) => debugPrint(option),
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                final toFormat = Utils.toTimeHm(widget.openingHours.to);
                textEditingController.text = toFormat;
                return SizedBox(
                  width: 200,
                  child: TextFormFieldWidget(
                    onEditingComplete: onFieldSubmitted,
                    focusNode: focusNode,
                    controller: textEditingController,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TimeInputFormatter(),
                    ],
                  ),
                );
              },
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


///  `HH:mm`
class TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueLength = newValue.text.length;

    if (newValueLength > 4) {
      return oldValue;
    }

    var selectionIndex = newValue.selection.end;
    var substrIndex = 0;
    final newText = StringBuffer();

    switch (newValueLength) {
      case 1:
        final hour = int.parse(newValue.text.substring(0, 1));
        if (hour >= 3) return oldValue;
        break;
      case 2:
        final hour = int.parse(newValue.text.substring(0, 2));
        if (hour >= 24) return oldValue;
        break;
      case 3:
        final minute = int.parse(newValue.text.substring(2, 3));
        if (minute >= 6) return oldValue;
        newText.write('${newValue.text.substring(0, substrIndex = 2)}:');
        if (newValue.selection.end >= 2) selectionIndex++;
        break;
      case 4:
        final minute = int.parse(newValue.text.substring(2, 4));
        if (minute >= 60) return oldValue;
        newText.write('${newValue.text.substring(0, substrIndex = 2)}:');
        if (newValue.selection.end >= 2) selectionIndex++;
        break;
    }

    if (newValueLength >= substrIndex) {
      newText.write(newValue.text.substring(substrIndex));
    }

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
