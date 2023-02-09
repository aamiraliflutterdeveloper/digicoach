import 'package:clients_digcoach/core/responsive.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants/menus.dart';
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
    _fetchClubs();
    // clubId();
    _fetchCourts();
    // _fetchCourtId();
    _fetchCoaches();
    _fetchReservations();
    // _fetchCoachId();
  }

  Future<void> _fetchClubs() async => await ref.read(clubProvider).getClubs();

  // Future<void> clubId() async => await ref.read(clubProvider).getClubId();

  Future<void> _fetchCourts() async =>
      await ref.read(courtProvider).getCourts();

  // Future<void> _fetchCourtId() async =>
  //     await ref.read(courtProvider).getCourtId();

  Future<void> _fetchReservations() async =>
      await ref.read(reservationProvider).getReservations();

  Future<void> _fetchCoaches() async =>
      await ref.read(coachProvider).getCoaches();

  // Future<void> _fetchCoachId() async =>
  //     await ref.read(coachProvider).getCoachId();

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive();
    responsive.init(context);
    final isDesktop = responsive.isDesktop;
    return  Scaffold(
            drawerEnableOpenDragGesture: false,
            appBar: const AppBarWidget(),
            drawer: isDesktop ? null : const DrawerWidget(),
            body: Row(
              children: [
                if (isDesktop) const Expanded(child: DrawerWidget()),
                Expanded(
                  flex: 5,
                  child: menus[ref.watch(homeProvider).currentIndex].widget,
                ),
              ],
            ),
          );
  }
}
