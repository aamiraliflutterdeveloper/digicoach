
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/colors.dart';
import '../../providers/club_provider.dart';
import '../../widgets/club_coach_card_widget.dart';
import '../../widgets/convex_tab_widget.dart';
import '../clubs/clubs_screen.dart';

class CoachesScreen extends ConsumerStatefulWidget {
  const CoachesScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CoachesScreenState();
}

class _CoachesScreenState extends ConsumerState<CoachesScreen> {
  @override
  Widget build(BuildContext context) {
    const titles = ['Coaches', 'Managers'];
    const widgets = [ClubCoachCardWidget(isCoach: true), ManagersCardWidget()];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'Coaches information and permissions',
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
                  currentIndex: ref.watch(coachProvider).coachManagerCurrentIndex,
                  onTap: () =>
                  ref.read(coachProvider).coachManagerCurrentIndex = index,
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


