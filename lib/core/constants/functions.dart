import 'dart:math';

import 'package:clients_digcoach/core/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> buildDialog(
    BuildContext context, {
      required Widget child,
    }) async {
  final width = MediaQuery.of(context).size.width;
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: SizedBox(
        width: width / 2,
        child: child,
      ),
    ),
  );
}
EdgeInsets padding(BuildContext context,
    {double? maxBreakingPoint,
      double? minPadding,
      double? maxPadding,
      bool hasSidebar = false}) {
 final responsive =   Responsive();
  responsive.init(context);

  final double defaultYPadding = responsive.isDesktop ? 40 : 16;
  final double defaultXPadding = responsive.isDesktop ? 40 : 16;
  final breakingPoint = maxBreakingPoint ?? 1150;
  final double padding = minPadding ?? defaultYPadding;
  final double xPadding = minPadding ?? defaultXPadding;
  // final sideBarWidth = hasSidebar ? responsive.sideBarWidth : 0;

  final threshold =
      responsive.screenWidth  - breakingPoint;
  final double horizontal =
  threshold > 0 ? max((maxPadding ?? threshold) / 2, xPadding) : xPadding;

  return EdgeInsets.symmetric(horizontal: horizontal, vertical: padding);
}