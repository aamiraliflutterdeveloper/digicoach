import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.onFieldSubmitted,
    this.hintText,
    this.dateOnPressed,
    this.onEditingComplete,
    this.timeOnPressed,
    this.isSuffix = false,
    this.isRequired = false,
    this.maxLines = 1,
    this.border,
    this.inputFormatters,
    this.validator,
    this.focusNode,
    this.autovalidateMode,
    this.onChanged,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final VoidCallback? dateOnPressed;
  final VoidCallback? timeOnPressed;
  final VoidCallback? onEditingComplete;
  final bool isSuffix;
  final bool isRequired;
  final int maxLines;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      autovalidateMode: autovalidateMode,
      style: const TextStyle(color: Colors.black),
      readOnly: isSuffix,
      maxLines: maxLines,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: isSuffix
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: dateOnPressed,
                    icon: const Icon(Icons.date_range),
                  ),
                  IconButton(
                    onPressed: timeOnPressed,
                    icon: const Icon(Icons.access_time),
                  ),
                ],
              )
            : null,
        border: border ?? const OutlineInputBorder(),
      ),
      onFieldSubmitted: onFieldSubmitted,
      validator: validator ??
          (isSuffix || !isRequired
              ? null
              : (title) =>
                  title == null || title.isEmpty ? 'field required' : null),
      controller: controller,
      inputFormatters: inputFormatters,
    );
  }
}

class NewTextFormFieldWidget extends StatefulWidget {
  const NewTextFormFieldWidget({
    super.key,
    required this.text,
    this.onFieldSubmitted,
    this.hintText,
    this.dateOnPressed,
    this.onEditingComplete,
    this.timeOnPressed,
    this.isSuffix = false,
    this.isRequired = false,
    this.maxLines = 1,
    this.border,
    this.inputFormatters,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
  });

  final String text;
  final ValueChanged<String>? onFieldSubmitted;
  final String? hintText;
  final VoidCallback? dateOnPressed;
  final VoidCallback? timeOnPressed;
  final VoidCallback? onEditingComplete;
  final bool isSuffix;
  final bool isRequired;
  final int maxLines;
  final InputBorder? border;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final ValueChanged<String>? onChanged;

  @override
  State<NewTextFormFieldWidget> createState() => _NewTextFormFieldWidgetState();
}

class _NewTextFormFieldWidgetState extends State<NewTextFormFieldWidget> {
  late TextEditingController controller;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(covariant NewTextFormFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.text != widget.text && !focusNode.hasFocus) {
      setState(() {
        controller.text = widget.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      autovalidateMode: widget.autovalidateMode,
      style: const TextStyle(color: Colors.black),
      readOnly: widget.isSuffix,
      maxLines: widget.maxLines,
      focusNode: focusNode,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: widget.isSuffix
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: widget.dateOnPressed,
                    icon: const Icon(Icons.date_range),
                  ),
                  IconButton(
                    onPressed: widget.timeOnPressed,
                    icon: const Icon(Icons.access_time),
                  ),
                ],
              )
            : null,
        border: widget.border ?? const OutlineInputBorder(),
      ),
      onFieldSubmitted: widget.onFieldSubmitted,
      validator: widget.validator ??
          (widget.isSuffix || !widget.isRequired
              ? null
              : (title) =>
                  title == null || title.isEmpty ? 'field required' : null),
      controller: controller,
      inputFormatters: widget.inputFormatters,
    );
  }
}
