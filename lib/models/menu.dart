import 'package:flutter/material.dart';

class Menu {
  final String title;
  final IconData icon;
  final Widget widget;

 const Menu({
    required this.title,
    required this.icon,
    required this.widget,
  });
}
