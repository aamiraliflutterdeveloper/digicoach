import 'package:clients_digcoach/core/constants/functions.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/colors.dart';
import '../../core/constants/menus.dart';
import '../../core/responsive.dart';
import '../../providers/home_provider.dart';
import 'home_menu_item_widget.dart';

class DrawerWidget extends ConsumerWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Drawer(
        elevation: 0,
        child: Column(
          children: List.generate(
            menus.length,
            (index) {
              final menu = menus[index];
              return Expanded(
                child: HomeMenuItemWidget(
                  title: menu.title,
                  icon: menu.icon,
                  onTap: () {
                    if (ref.watch(clubProvider).selectedClubId == null &&
                        index == 5) {
                      buildDialog(context,
                          child: const Text('Select Club First'));
                    } else {
                      ref.read(homeProvider).currentIndex = index;
                    }
                    Scaffold.of(context).closeDrawer();
                  },
                  itemColor: ref.watch(homeProvider).currentIndex == index
                      ? kSecondaryColor
                      : kPrimaryColor,
                ),
              );
            },
          ),
        ),
      );
}
