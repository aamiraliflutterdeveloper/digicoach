import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../core/constants/colors.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double value = .4;
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 25,
      animationDuration: 2000,
      percent: value,
      center: Text('${(value * 100).round()}%'),
      barRadius: const Radius.circular(30),
      progressColor: kPrimaryColor,
    );
  }
}
