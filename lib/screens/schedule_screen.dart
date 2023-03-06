import 'package:clients_digcoach/providers/schedule_provider.dart';
import 'package:clients_digcoach/widgets/calendars/coaches_calendar_views.dart';
import 'package:clients_digcoach/widgets/calendars/courts_calendar_views.dart';
import 'package:clients_digcoach/widgets/calendars/players_calendar_views.dart';
import 'package:clients_digcoach/widgets/convex_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/calendars/groups_calendar_views.dart';

class ScheduleScreen extends ConsumerStatefulWidget {
  const ScheduleScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<ScheduleScreen> {
  final _titles = const ['Courts', 'Coaches', 'Groups', 'Players'];
  final _widgets = const [
    CourtsCalendarViews(),
    CoachesCalendarViews(),
    GroupsCalendarViews(),
    PlayersCalendarViews(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...List.generate(
                _titles.length,
                (index) => Expanded(
                  child: ConvexTabWidget(
                    index: index,
                    titles: _titles,
                    currentIndex: ref.watch(scheduleProvider).currentIndex,
                    onTap: () =>
                        ref.read(scheduleProvider).currentIndex = index,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          _widgets[ref.watch(scheduleProvider).currentIndex]
        ],
      ),
    );
  }
}
