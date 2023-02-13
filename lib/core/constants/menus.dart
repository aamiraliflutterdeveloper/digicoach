import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clients_digcoach/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

import '../../models/menu.dart';
import '../../screens/clubs/clubs_screen.dart';
import '../../screens/coaches/coaches_screen.dart';
import '../../screens/customers_screen.dart';
import '../../screens/evaluations_screen.dart';
import '../../screens/groups_screen.dart';
import '../../screens/lessons_screen.dart';
import '../../screens/messages_screen.dart';
import '../../screens/other_screen.dart';
import '../../screens/schedule/schedule_screen.dart';

final menus = [
  const Menu(
    title: 'Dashboard',
    icon: FontAwesomeIcons.chartLine,
    widget: DashBoardScreen(),
  ),
  const Menu(
    title: 'Clubs',
    icon: Icons.sports_tennis_rounded,
    widget: ClubsScreen(),
  ),
  const  Menu(
    title: 'Coaches',
    icon: Icons.people,
    widget: CoachesScreen(),
  ),
  const Menu(
    title: 'Customers',
    icon: Icons.people,
    widget: CustomersScreen(),
  ),
  const  Menu(
    title: 'Groups',
    icon: Icons.people,
    widget: GroupsScreen(),
  ),
  const Menu(
    title: 'Schedule',
    icon: FontAwesomeIcons.solidCalendarDays,
    widget: ScheduleScreen(),
  ),
  const  Menu(
    title: 'Lessons',
    icon: Icons.video_collection,
    widget: LessonsScreen(),
  ),
  const Menu(
    title: 'Evaluations',
    icon: FontAwesomeIcons.listCheck,
    widget: EvaluationsScreen(),
  ),
  const Menu(
    title: 'Messages',
    icon: FontAwesomeIcons.comments,
    widget: MessagesScreen(),
  ),
  const Menu(
    title: 'Other',
    icon: Icons.threesixty_sharp,
    widget: OtherScreen(),
  ),
];
