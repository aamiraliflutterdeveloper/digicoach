import 'package:clients_digcoach/core/constants/colors.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/club_coach_card_widget.dart';
import '../../widgets/convex_tab_widget.dart';

class ClubsScreen extends ConsumerWidget {
  const ClubsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const titles = ['Clubs', 'Managers'];
    const widgets = [ClubCoachCardWidget(isCoach: false), ManagersCardWidget()];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'Clubs information and permissions',
            style: TextStyle(
              fontSize: 25,
              color: kPrimaryColor,
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
                  currentIndex:
                      ref.watch(clubProvider).coachManagerCurrentIndex,
                  onTap: () =>
                      ref.read(clubProvider).coachManagerCurrentIndex = index,
                ),
              ),
            ),
          ),
          Expanded(
            child: widgets[ref.watch(clubProvider).coachManagerCurrentIndex],
          ),
        ],
      ),
    );
  }
}

class ManagersCardWidget extends StatelessWidget {
  const ManagersCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Managers',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
