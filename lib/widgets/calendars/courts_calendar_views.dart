import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:clients_digcoach/widgets/calendars/week_view_screen.dart';
import 'package:clients_digcoach/widgets/schedule/heat_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../schedule/coaches_view_widget.dart';
import '../schedule/day_view_widget.dart';
import '../schedule/week_view_widget.dart';
import '../tab_widget.dart';

class CourtsCalendarViews extends ConsumerStatefulWidget {
  const CourtsCalendarViews({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CourtsCalendarViewsState();
}

class _CourtsCalendarViewsState extends ConsumerState<CourtsCalendarViews> {
  final _titles = const ['Heat Map', 'Day View', 'Week View'];
  final _widgets = const [
    HeatMapWidget(isCoachView: false),
    DayViewWidget(isCoachView: false),
    WeekViewWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  child: TabWidget(
                    index: index,
                    title: _titles[index],
                    currentIndex: ref.watch(courtProvider).courtsViewIndex,
                    onTap: () =>
                        ref.read(courtProvider).courtsViewIndex = index,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          _widgets[ref.watch(courtProvider).courtsViewIndex]
        ],
      ),
    );
  }
}
