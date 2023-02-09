import 'package:flutter/material.dart';
import '../core/constants/colors.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.title,
    this.onTap,
    this.borderRadius,
    this.verticalPadding, required this.horizontalPadding,
  });

  final int index;
  final int currentIndex;
  final double? verticalPadding;
  final double horizontalPadding;
  final String title;
  final GestureTapCallback? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: verticalPadding??4,horizontal: horizontalPadding),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: currentIndex == index ? kPrimaryColor : Colors.white,
              border: Border.all(color: kPrimaryColor)),
          child: Text(
            title,
            style: TextStyle(
              color: currentIndex == index ? Colors.white : kPrimaryColor,
            ),
          ),
        ),
      );
}
