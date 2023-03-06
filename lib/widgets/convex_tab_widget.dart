import 'package:clients_digcoach/data/colors.dart';
import 'package:flutter/material.dart';

class ConvexTabWidget extends StatelessWidget {
  const ConvexTabWidget({
    super.key,
    required this.index,
    required this.titles,
    required this.currentIndex,
    required this.onTap,
  });

  final int index;
  final int currentIndex;
  final List<String> titles;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    const convexBorder = BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
    );
    return InkWell(
      borderRadius: convexBorder,
      onTap: onTap,
      child: Container(
        height: 40,
        width: 150,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: currentIndex == index
              ? AppColors.secondaryColor
              : AppColors.primaryColor,
          borderRadius: convexBorder,
        ),
        child: Text(
          titles[index],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
