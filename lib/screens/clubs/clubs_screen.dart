import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/models/end_drawer_popup.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/widgets/clubs/manager_data_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/home_provider.dart';
import '../../widgets/clubs/club_card_widget.dart';
import '../../widgets/convex_tab_widget.dart';

class ClubsScreen extends ConsumerWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const titles = ['Clubs', 'Managers'];
    const widgets = [ClubCardWidget(), ManagersCardWidget()];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'Clubs information and permissions',
            style: TextStyle(
              fontSize: 25,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: List.generate(
                titles.length,
                (index) => ConvexTabWidget(
                  index: index,
                  titles: titles,
                  currentIndex: ref.watch(clubProvider).tabIndex,
                  onTap: () => ref.read(clubProvider).tabIndex = index,
                ),
              ),
            ),
          ),
          Expanded(child: widgets[ref.watch(clubProvider).tabIndex]),
        ],
      ),
    );
  }
}

class ManagersCardWidget extends ConsumerWidget {
  const ManagersCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20).copyWith(
          topLeft: const Radius.circular(0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(flex: 5),
                const Text(
                  'Managers',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(flex: 4),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: AppColors.primaryColor,
                  ),
                  label: const Text('New Manager'),
                  icon: const CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                  onPressed: () {
                    ref.read(homeProvider).endDrawerPopup =
                        EndDrawerPopup.addManager;
                    ref.read(clubProvider).setIsFromEdit(false);
                    ref.read(clubProvider).getPermissions();
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Modify or create new managers',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const Expanded(child: ManagerDataGridWidget()),
          ],
        ),
      ),
    );
  }
}





