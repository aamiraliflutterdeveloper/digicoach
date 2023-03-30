import 'package:clients_digcoach/data/colors.dart';
import 'package:flutter/material.dart';

class EmptyRecordWidget extends StatelessWidget {
  final String title;
  const EmptyRecordWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(title, style: const TextStyle(color: Colors.white)),
        )));
  }
}
