import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../text_form_field_widget.dart';

class FromToFieldWidget extends StatelessWidget {
  const FromToFieldWidget({
    super.key,
    required this.toController,
    required this.fromController,
    this.onDelete, this.inputFormatters,
  });

  final TextEditingController toController;
  final TextEditingController fromController;
  final VoidCallback? onDelete;
  final List<TextInputFormatter>? inputFormatters;

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
                controller: fromController,
                inputFormatters:inputFormatters?? [
                  FilteringTextInputFormatter.digitsOnly,
                  HoraInputFormatter(),
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
                controller: toController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  HoraInputFormatter(),
                ],
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
