import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.onFieldSubmitted,
    this.hintText,
    this.dateOnPressed,
    this.timeOnPressed,
    this.isSuffix = false,
    this.isRequired = false,
    this.maxLines = 1,
    this.border, this.inputFormatters, this.validator,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final VoidCallback? dateOnPressed;
  final VoidCallback? timeOnPressed;
  final bool isSuffix;
  final bool isRequired;
  final int maxLines;
  final InputBorder? border;
 final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black),
      readOnly: isSuffix,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: isSuffix
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: dateOnPressed,
                      icon: const Icon(Icons.date_range)),
                  IconButton(
                      onPressed: timeOnPressed,
                      icon: const Icon(Icons.access_time)),
                ],
              )
            : null,
        border: border ?? const OutlineInputBorder(),
      ),
      onFieldSubmitted: onFieldSubmitted,
      validator:validator??( isSuffix || isRequired
          ? null
          : (title) => title != null && title.isEmpty ? 'field required' : null),
      controller: controller,
      inputFormatters: inputFormatters,
    );
  }
}
