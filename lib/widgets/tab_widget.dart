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
  });

  final int index;
  final int currentIndex;
  final String title;
  final GestureTapCallback? onTap;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        onTap: onTap,
        child: Container(
          height:30,
          width: 200,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: currentIndex == index ? kPrimaryColor : Colors.white,
              borderRadius: borderRadius ?? BorderRadius.circular(15),
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
