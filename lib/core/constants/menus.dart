import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clients_digcoach/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../../models/menu.dart';
import '../../screens/clubs/clubs_screen.dart';
import '../../screens/coaches_screen.dart';
import '../../screens/customers_screen.dart';
import '../../screens/evaluations_screen.dart';
import '../../screens/groups_screen.dart';
import '../../screens/lessons_screen.dart';
import '../../screens/messages_screen.dart';
import '../../screens/other_screen.dart';
import '../../screens/schedule/schedule_screen.dart';

const menus = [
  Menu(
    title: 'Dashboard',
    icon: FontAwesomeIcons.chartLine,
    widget: DashBoardScreen(),
  ),
  Menu(
    title: 'Clubs',
    icon: Icons.sports_tennis_rounded,
    widget: ClubsScreen(),
  ),
  Menu(
    title: 'Coaches',
    icon: Icons.people,
    widget: CoachesScreen(),
  ),
  Menu(
    title: 'Customers',
    icon: Icons.people,
    widget: CustomersScreen(),
  ),
  Menu(
    title: 'Groups',
    icon: Icons.people,
    widget: GroupsScreen(),
  ),
  Menu(
    title: 'Schedule',
    icon: FontAwesomeIcons.solidCalendarDays,
    widget: ScheduleScreen(),
  ),
  Menu(
    title: 'Lessons',
    icon: Icons.video_collection,
    widget: LessonsScreen(),
  ),
  Menu(
    title: 'Evaluations',
    icon: FontAwesomeIcons.listCheck,
    widget: EvaluationsScreen(),
  ),
  Menu(
    title: 'Messages',
    icon: FontAwesomeIcons.comments,
    widget: MessagesScreen(),
  ),
  Menu(
    title: 'Other',
    icon: Icons.threesixty_sharp,
    widget: OtherScreen(),
  ),
];
