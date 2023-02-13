import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, this.onPressed, this.fixedSize, required this.title});

  final VoidCallback? onPressed;
  final Size? fixedSize;
  final String title;

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        fixedSize: fixedSize,
      ),
      child:  Text(title),
    );
}
