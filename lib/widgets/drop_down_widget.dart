import 'package:flutter/material.dart';

import '../core/constants/colors.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    super.key,
    this.currentValue,
    this.onChanged,
    required this.items,
    required this.id,
    required this.hint,
    this.validator,
  });

  final String? currentValue;
  final String hint;
  final List<String> id;
  final ValueChanged<String?>? onChanged;
  final List<String> items;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) => DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          validator: validator,
          value: currentValue,
          onChanged: onChanged,
          decoration: const InputDecoration(border: InputBorder.none),
          hint: Text(
            hint,
            style: const TextStyle(color: Colors.grey),
          ),
          iconSize: 25,
          icon: const Icon(Icons.arrow_drop_down),
          items: List.generate(
            items.length,
            (index) => DropdownMenuItem(
              value: id[index],
              child: Text(
                items[index],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      );
}
