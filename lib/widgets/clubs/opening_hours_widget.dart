import 'package:clients_digcoach/models/club/opening_hours.dart';
import 'package:clients_digcoach/providers/add_club_provider.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/club/opening_time.dart';
import 'from_to_widget.dart';

class OpeningHoursWidget extends ConsumerStatefulWidget {
  const OpeningHoursWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OpeningHoursWidgetState();
}

class _OpeningHoursWidgetState extends ConsumerState<OpeningHoursWidget> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(clubProvider).isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...buildOpeningHours(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: const Text('Next'),
                    onPressed: () async {
                      ref.read(addClubProvider).tabIndex = 2;
                    },
                  ),
                ],
              ),
            ],
          );
  }

  List<Widget> buildOpeningHours() {
    final openingHours = ref.watch(addClubProvider).club.openingHours;

    return List.generate(
      openingHours.length,
      (index) {
        final openingHour = openingHours[index];

        return OpeningHourWidget(
          hours: openingHour,
          onChecked: (isActive) {
            if (isActive) {
              addTime(openingHour);
            } else {
              removeAllTimes(openingHour);
            }
          },
          onTimeAdded: () => addTime(openingHour),
          onTimeDeleted: (index) => deleteTime(openingHour, index),
          onChanged: (openingHour) => changeTime(openingHour),
        );
      },
    );
  }

  void addTime(OpeningHours openingHour) {
    final newTime = openingHour.times.isEmpty
        ? OpeningTime.standard()
        : OpeningTime(
            from: openingHour.times.last.to.add(const Duration(hours: 1)),
            to: openingHour.times.last.to.add(const Duration(hours: 2)),
          );

    openingHour.times.add(newTime);
    setState(() {});
  }

  void removeAllTimes(OpeningHours openingHour) {
    openingHour.times.clear();
    setState(() {});
  }

  void deleteTime(OpeningHours openingHour, int index) {
    openingHour.times.removeAt(index);
    setState(() {});
  }

  void changeTime(OpeningHours openingHour) {
    ref.read(addClubProvider).updateOpeningHours(openingHour);
  }
}

class OpeningHourWidget extends StatefulWidget {
  const OpeningHourWidget({
    super.key,
    required this.hours,
    required this.onTimeAdded,
    required this.onTimeDeleted,
    required this.onChecked,
    required this.onChanged,
  });

  final OpeningHours hours;
  final VoidCallback onTimeAdded;
  final ValueChanged<int> onTimeDeleted;
  final ValueChanged<bool> onChecked;
  final ValueChanged<OpeningHours> onChanged;

  @override
  State<OpeningHourWidget> createState() => _OpeningHourWidgetState();
}

class _OpeningHourWidgetState extends State<OpeningHourWidget> {
  @override
  Widget build(BuildContext context) {
    final times = widget.hours.times;
    final isActive = times.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: 180, child: buildCheckbox(isActive)),
            IconButton(
              onPressed: widget.onTimeAdded,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 8),
        times.isEmpty || !isActive
            ? const SizedBox()
            : Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: times.length,
                  separatorBuilder: (context, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final time = times[index];

                    return FromToWidget(
                      time: time,
                      onDelete: () => widget.onTimeDeleted(index),
                      onChanged: (time) {
                        final newTimes = List.of(times);
                        newTimes[index] = time;

                        final newHours = widget.hours.copy(times: newTimes);
                        widget.onChanged(newHours);
                      },
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget buildCheckbox(bool isActive) {
    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    final day = widget.hours.day.toString();

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onChecked(!isActive),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: isActive,
            onChanged: (isActive) => widget.onChecked(isActive!),
          ),
          const SizedBox(width: 4),
          Text(day, style: style)
        ],
      ),
    );
  }
}
