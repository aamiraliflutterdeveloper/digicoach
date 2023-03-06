import 'package:clients_digcoach/data/clubs.dart';
import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/models/end_drawer_popup.dart';
import 'package:clients_digcoach/providers/add_club_provider.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/home_provider.dart';
import 'club_data_grid_widget.dart';

class ClubCardWidget extends ConsumerWidget {
  const ClubCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => Card(
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
                    'Clubs',
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
                    label: const Text('New Club'),
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
                      final clubId = ref.read(clubProvider).clubs.length + 1;
                      ref.read(addClubProvider).club =
                          defaultClub(clubId: clubId);

                      ref.read(homeProvider).endDrawerPopup =
                          EndDrawerPopup.addClub;

                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Modify or create new clubs',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const Expanded(child: ClubDataGridWidget()),
            ],
          ),
        ),
      );
}
