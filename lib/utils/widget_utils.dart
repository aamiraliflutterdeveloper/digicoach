import 'dart:math';

import 'package:clients_digcoach/utils/responsive.dart';
import 'package:clients_digcoach/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class WidgetUtils {
  static List<Widget> addSpaceBetween({
    required List<Widget> children,
    required Widget space,
  }) {
    if (children.isEmpty) return <Widget>[];
    if (children.length == 1) return children;

    final list = [children.first, space];
    for (int i = 1; i < children.length - 1; i++) {
      final child = children[i];
      list.add(child);
      list.add(space);
    }
    list.add(children.last);

    return list;
  }

  static Future<void> buildDialog(
    BuildContext context, {
    required Widget child,
  }) async {
    final width = MediaQuery.of(context).size.width;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(width: width / 2, child: child),
      ),
    );
  }

  /// loading dialog ...
  static Future<void> loadingDialog(BuildContext context, String title) async{
    return showDialog(
        useSafeArea: false,
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return  LoadingWidget(title: title);
        });
  }


  static EdgeInsets padding(
    BuildContext context, {
    double? maxBreakingPoint,
    double? minPadding,
    double? maxPadding,
    bool hasSidebar = false,
  }) {
    final responsive = Responsive();
    responsive.init(context);

    final double defaultYPadding = responsive.isDesktop ? 40 : 16;
    final double defaultXPadding = responsive.isDesktop ? 40 : 16;
    final breakingPoint = maxBreakingPoint ?? 1150;
    final double padding = minPadding ?? defaultYPadding;
    final double xPadding = minPadding ?? defaultXPadding;

    final threshold = responsive.screenWidth - breakingPoint;
    final double horizontal =
        threshold > 0 ? max((maxPadding ?? threshold) / 2, xPadding) : xPadding;

    return EdgeInsets.symmetric(horizontal: horizontal, vertical: padding);
  }

  static Widget requiredText(String text) => Row(
        children: [
          const Text('*', style: TextStyle(color: Colors.red, fontSize: 16)),
          const Padding(padding: EdgeInsets.all(3.0)),
          Text(
            text,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
