import 'dart:math';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:clients_digcoach/models/holiday.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../core/constants/functions.dart';
import 'from_to_field_widget.dart';

class HolidaysWidget extends StatefulWidget {
  const HolidaysWidget({super.key});

  @override
  State<HolidaysWidget> createState() => _HolidaysWidgetState();
}

class _HolidaysWidgetState extends State<HolidaysWidget> {
  final List<TextEditingController> fromControllers = [];

  final List<TextEditingController> toControllers = [];

  // final mondayToController = TextEditingController();
  // DateTime tempDate =  DateFormat("yyyy-MM-dd hh:mm:ss").parse(savedDateString);
  // String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  DateTime parsedDateFrom = DateTime.parse('2022-03-20 09:00');

  DateTime parsedDateTo = DateTime.parse('2022-03-20 20:00');

  List<Holiday> holidays = [];

  bool isActive  = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return ListView(
      padding: padding(context),
      children: [
        Row(
          children: [
            Checkbox(value: isActive, onChanged: (value) => setState(() => isActive= value!)),
            const Text('Holidays', style: style),
            const SizedBox(width: 50),
            IconButton(
              onPressed: () {
                if(isActive){
                  setState(() {
                    fromControllers.add(TextEditingController(text:DateFormat("yyyy-MM-dd").format(parsedDateFrom.add(Duration(days: holidays.length+1))))) ;
                    toControllers.add(TextEditingController(text: DateFormat("yyyy-MM-dd").format(parsedDateTo.add(Duration(days: holidays.length+3)))));
                  });

                  holidays.add(
                    Holiday(
                      id: '${holidays.length + 1}',
                      clubId:  '1',
                      holidaysFrom: DateTime.parse('${fromControllers.first.text} 00:00')
                          .add(const Duration(days: 1)),
                      holidaysTo: DateTime.parse('${toControllers.first.text} 00:00'),
                    ),
                  );

                }

              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 30),
        holidays.isEmpty || !isActive
            ? const Text('Un Available',style: style)
            : ListView.separated(
          shrinkWrap: true,
          itemCount:holidays.length,
          // toControllers.length,
          // openingHours.where((element) => element.dayId == '1').length,
          // openingHours.length,
          separatorBuilder: (context, _) => const SizedBox(height: 10),
          itemBuilder: (context, index) => FromToFieldWidget(
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              DateTextFormatter()
            ],
            toController: toControllers[index],
            fromController: fromControllers[index],
            onDelete: () {
              holidays.removeAt(index);
              setState(() {});
            },
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

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
