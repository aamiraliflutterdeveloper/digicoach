import 'package:clients_digcoach/data/colors.dart';
import 'package:flutter/material.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.title,
    required this.onTap,
    this.height = 32,
    this.width = 200,
    this.borderRadius,
  });

  final int index;
  final int currentIndex;
  final String title;
  final VoidCallback onTap;
  final BorderRadius? borderRadius;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final color = currentIndex == index ? Colors.white : AppColors.primaryColor;
    final backgroundColor =
        currentIndex == index ? AppColors.primaryColor : Colors.white;

    return InkWell(
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? BorderRadius.circular(15),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Text(title, style: TextStyle(color: color)),
      ),
    );
  }
}
