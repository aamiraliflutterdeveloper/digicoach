import 'package:clients_digcoach/providers/schedule_provider.dart';
import 'package:clients_digcoach/screens/schedule/coaches_view_screen.dart';
import 'package:clients_digcoach/screens/schedule/day_vew_screeen.dart';
import 'package:clients_digcoach/screens/schedule/heat_map_screen.dart';
import 'package:clients_digcoach/screens/schedule/weeK_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/tab_widget.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<ScheduleScreen> {
  final _titles = const ['Heat Map', 'Day View', 'Week View', 'Coaches View'];
  final _widgets = const [
    HeatMapScreen(),
    DayViewScreen(),
    WeekViewScreen(),
    CoachesViewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(scheduleProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ...List.generate(
                _titles.length,
                (index) => Expanded(
                  flex: 8,
                  child: TabWidget(
                    index: index,
                    title: _titles[index],
                    currentIndex: provider.currentIndex,
                    onTap: () => provider.currentIndex = index,
                    horizontalPadding: 1,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 32),
          _widgets[provider.currentIndex]
        ],
      ),
    );
  }
}
