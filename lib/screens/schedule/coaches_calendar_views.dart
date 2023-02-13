import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/court_provider.dart';
import '../../providers/reservation_provider.dart';
import '../../widgets/drop_down_widget.dart';
import '../../widgets/schedule/coaches_view_widget.dart';
import '../../widgets/schedule/day_view_widget.dart';
import '../../widgets/schedule/heat_map_widget.dart';
import '../../widgets/schedule/week_view_widget.dart';
import '../../widgets/tab_widget.dart';

class CoachesCalendarViews extends ConsumerStatefulWidget {
  const CoachesCalendarViews({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CoachesCalendarViewsState();
}

class _CoachesCalendarViewsState extends ConsumerState<CoachesCalendarViews> {
  final _titles = const ['Heat Map', 'Day View', 'Coaches View'];
  final _widgets = const [
    HeatMapWidget(isCoachView: true),
    DayViewWidget(isCoachView: true),
    CoachesViewWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final coaches = ref.read(coachProvider).coachesByClubId;
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
                    currentIndex: ref.watch(coachProvider).coachesViewIndex,
                    onTap: () =>
                        ref.read(coachProvider).coachesViewIndex = index,
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(
            width: 200,
            child: DropDownWidget(
              currentValue: ref.watch(coachProvider).selectedCoachId,
              onChanged: _onChangedCoach,
              values: coaches.map((e) => e.id).toList(),
              items: coaches.map((e) => e.name).toList(),
            ),
          ),
          const SizedBox(height: 16),
          _widgets[ref.watch(coachProvider).coachesViewIndex]
        ],
      ),
    );
  }

  void _onChangedCoach(String? value) {
    ref.read(coachProvider).selectedCoachId = value!;
    ref
        .read(reservationProvider)
        .getReservationsByCoachId(coachId: value);

  }
}
