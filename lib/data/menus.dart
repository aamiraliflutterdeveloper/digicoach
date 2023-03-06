import 'package:clients_digcoach/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Menus {
  static final all = [
    dashboard,
    clubs,
    coaches,
    customers,
    groups,
    schedule,
    lessons,
    evaluations,
    messages,
    other,
  ];

  static const dashboard = Menu(
    title: 'Dashboard',
    icon: FontAwesomeIcons.chartLine,
  );
  static const clubs = Menu(
    title: 'Clubs',
    icon: Icons.sports_tennis_rounded,
  );

  static const coaches = Menu(
    title: 'Coaches',
    icon: Icons.people,
  );

  static const customers = Menu(
    title: 'Customers',
    icon: Icons.people,
  );
  static const groups = Menu(
    title: 'Groups',
    icon: Icons.people,
  );

  static const schedule = Menu(
    title: 'Schedule',
    icon: FontAwesomeIcons.solidCalendarDays,
  );

  static const lessons = Menu(
    title: 'Lessons',
    icon: Icons.video_collection,
  );

  static const evaluations = Menu(
    title: 'Evaluations',
    icon: FontAwesomeIcons.listCheck,
  );
  static const messages = Menu(
    title: 'Messages',
    icon: FontAwesomeIcons.comments,
  );

  static const other = Menu(
    title: 'Other',
    icon: Icons.threesixty_sharp,
  );
}
