import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:clients_digcoach/widgets/coaches/coach_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/convex_tab_widget.dart';

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
    const titles = ['Coaches'];
    const widgets = [CoachesCardWidget()];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 50),
          const Text(
            'Coaches information and permissions',
            style: TextStyle(
              fontSize: 25,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          buildTabs(titles),
          Expanded(child: widgets[ref.watch(coachProvider).tabIndex]),
        ],
      ),
    );
  }

  Widget buildTabs(List<String> titles) => Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Row(
          children: List.generate(
            titles.length,
            (index) => ConvexTabWidget(
              index: index,
              titles: titles,
              currentIndex: ref.watch(coachProvider).tabIndex,
              onTap: () => ref.read(coachProvider).tabIndex = index,
            ),
          ),
        ),
      );
}






