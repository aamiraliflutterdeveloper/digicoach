import 'package:clients_digcoach/data/colors.dart';
import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatelessWidget {
  const DropDownWidget({
    super.key,
    this.hintText = 'Please select an Option',
    this.items = const [],
    this.values = const [],
    this.currentValue,
    this.onChanged,
    this.validator,
  });

  final String? hintText;
  final List<T> items;
  final List<T> values;
  final T? currentValue;
  final void Function(T?)? onChanged;
  final FormFieldValidator<T>? validator;

  @override
  Widget build(BuildContext context) => DropdownButtonHideUnderline(
        child: DropdownButtonFormField<T>(
          validator: validator,
          value: currentValue,
          onChanged: onChanged,
          decoration: const InputDecoration(border: InputBorder.none),
          hint: Text(
            '$hintText',
            style: const TextStyle(color: Colors.grey),
          ),
          iconSize: 25,
          icon: const Icon(Icons.arrow_drop_down),
          items: [
            for (int i = 0; i < items.length; i++)
              DropdownMenuItem<T>(
                value: values[i],
                child: Text(
                  '${items[i]}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
          ],
        ),
      );
}
