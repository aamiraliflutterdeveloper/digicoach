import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/data/menus.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/menu.dart';
import '../../providers/coach_provider.dart';
import '../../providers/court_provider.dart';
import '../../providers/home_provider.dart';
import '../../providers/reservation_provider.dart';
import 'home_menu_item_widget.dart';

class DrawerWidget extends ConsumerStatefulWidget {
  const DrawerWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends ConsumerState<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final menus = Menus.all;

    return Drawer(
      elevation: 0,
      child: ReorderableListView(
        onReorder: _onReorder,
        children: List.generate(
          menus.length,
          (index) {
            final menu = menus[index];

            return HomeMenuItemWidget(
              key: ValueKey(menu),
              title: menu.title,
              icon: menu.icon,
              onTap: () => _onTap(index),
              itemColor: ref.watch(homeProvider).currentIndex == index
                  ? AppColors.secondaryColor
                  : AppColors.primaryColor,
            );
          },
        ),
      ),
    );
  }

  void _onTap(int index) {
    ref.read(homeProvider).currentIndex = index;
    if (index == 5) {
      final clubId = ref.watch(clubProvider).selectedClubId;
      final courtNumber = ref.watch(courtProvider).selectedCourtNumber;
      final coachId = ref.watch(coachProvider).selectedCoachId;
      ref.read(reservationProvider).getReservationsByClubId(clubId!);
      ref.read(courtProvider).getCourtsByClubId(clubId, ref);
      ref.read(courtProvider).getCourtNumber(clubId);
      ref
          .read(reservationProvider)
          .getReservationsByCourtNumber(courtNumber ?? 1);
      ref.read(coachProvider).getCoachId(clubId);
      ref.read(coachProvider).getCoachesByClubId(clubId);
      ref.read(reservationProvider).getReservationsByCoachId(coachId: coachId!);
    }
    // if (!mounted) return;
    Scaffold.of(context).closeDrawer();
  }

  void _onReorder(int oldIndex, int newIndex) => setState(() {
        final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
        ref.watch(homeProvider).currentIndex = index;

        final menu = Menus.all.removeAt(oldIndex);
        Menus.all.insert(index, menu);
      });
}
