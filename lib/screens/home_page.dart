import 'package:clients_digcoach/data/menus.dart';
import 'package:clients_digcoach/models/end_drawer_popup.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/home_provider.dart';
import 'package:clients_digcoach/screens/clubs/add_club_screen.dart';
import 'package:clients_digcoach/screens/clubs/add_manager_screen.dart';
import 'package:clients_digcoach/screens/clubs/clubs_screen.dart';
import 'package:clients_digcoach/screens/coaches/add_coach_screen.dart';
import 'package:clients_digcoach/screens/coaches/coaches_screen.dart';
import 'package:clients_digcoach/screens/customers_screen.dart';
import 'package:clients_digcoach/screens/dashboard_screen.dart';
import 'package:clients_digcoach/screens/evaluations_screen.dart';
import 'package:clients_digcoach/screens/groups_screen.dart';
import 'package:clients_digcoach/screens/lessons_screen.dart';
import 'package:clients_digcoach/screens/messages_screen.dart';
import 'package:clients_digcoach/screens/other_screen.dart';
import 'package:clients_digcoach/screens/schedule_screen.dart';
import 'package:clients_digcoach/utils/responsive.dart';
import 'package:clients_digcoach/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/menu.dart';
import '../providers/coach_provider.dart';
import '../providers/court_provider.dart';
import '../providers/reservation_provider.dart';
import '../widgets/home/app_bar_widget.dart';
import '../widgets/home/drawer_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  Future<void> _fetchData() async {

    if (context.mounted) {
       ref.read(clubProvider).getManagers(context);
      await ref.read(coachProvider).getCoaches(context);
    }
    await ref.read(clubProvider).getClubs();
    await ref.read(clubProvider).getClub();
    await ref.read(courtProvider).getCourts();

    await ref.read(reservationProvider).getReservations();
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive();
    responsive.init(context);
    final isDesktop = responsive.isDesktop;
    final index = ref.watch(homeProvider).currentIndex;
    final menu = Menus.all[index];

    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: const AppBarWidget(),
      drawer: isDesktop ? null : const DrawerWidget(),
      endDrawer: buildEndDrawer(),
      onEndDrawerChanged: (val) =>
          ref.watch(homeProvider).endDrawerChanges = val,
      body: Row(
        children: [
          if (isDesktop) const Expanded(child: DrawerWidget()),
          Expanded(flex: 5, child: buildMenu(menu)),
        ],
      ),
    );
  }

  Widget buildEndDrawer() {
    final size = MediaQuery.of(context).size;

    return Material(
      child: SizedBox(
        height: size.height,
        width: size.width >= 800 ? size.width * .5 : size.width,
        child: endDrawerScreen,
      ),
    );
  }

  Widget get endDrawerScreen {
    final endDrawerPopup = ref.watch(homeProvider).endDrawerPopup;

    switch (endDrawerPopup) {
      case EndDrawerPopup.addClub:
        return const AddClubScreen();
      case EndDrawerPopup.addManager:
        return const AddManagerScreen();
      case EndDrawerPopup.addCoach:
      default:
        return const AddCoachScreen();
    }
  }

  Widget buildMenu(Menu menu) {
    switch (menu) {
      case Menus.dashboard:
        return const DashboardScreen();
      case Menus.clubs:
        return const ClubsScreen();
      case Menus.coaches:
        return const CoachesScreen();
      case Menus.customers:
        return const CustomersScreen();
      case Menus.groups:
        return const GroupsScreen();
      case Menus.schedule:
        return const ScheduleScreen();
      case Menus.lessons:
        return const LessonsScreen();
      case Menus.evaluations:
        return const EvaluationsScreen();
      case Menus.messages:
        return const MessagesScreen();
      case Menus.other:
      default:
        return const OtherScreen();
    }
  }
}
