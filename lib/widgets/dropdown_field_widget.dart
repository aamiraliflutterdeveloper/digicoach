import 'package:flutter/material.dart';

class DropdownFieldWidget extends StatelessWidget {
  const DropdownFieldWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final DateTime value;
  final List<DateTime> items;
  final ValueChanged<DateTime?> onChanged;
  final FormFieldValidator<DateTime>? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      value: value,
      items: items.map<DropdownMenuItem<DateTime>>((value) {
        final formattedHours = '${value.hour}'.padLeft(2, '0');
        final formattedMinutes = '${value.minute}'.padLeft(2, '0');
        final time = '$formattedHours:$formattedMinutes';

        return DropdownMenuItem<DateTime>(
          value: value,
          child: Text(
            time,
            style: const TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(border: OutlineInputBorder()),
    );
  }
}
