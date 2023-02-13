import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/functions.dart';
import '../../core/enums/days_week.dart';
import '../../models/opening_hours.dart';
import 'from_to_field_opening_hours_widget.dart';

class OpeningHoursWidget extends ConsumerStatefulWidget {
  const OpeningHoursWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OpeningHoursWidgetState();
}

class _OpeningHoursWidgetState extends ConsumerState<OpeningHoursWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) async => await ref.read(clubProvider).getOpeningHoursByClubId());
  }

  @override
  Widget build(BuildContext context) {
    final openingHoursByClubId = ref.watch(clubProvider).openingHoursByClubId;
    return ref.watch(clubProvider).isLoading
        ? const CircularProgressIndicator()
        : ListView(
            padding: padding(context),
            children: List.generate(
              DaysWeek.values.length,
                  (index) {
                final dayWeek = DaysWeek.values[index];
                return DayOpeningHourWidget(
                  items: openingHoursByClubId
                      .where((element) => element.daysWeek == dayWeek)
                      .toList(),
                  day: dayWeek.toString(),
                  addTime: () => _addOpeningHour(openingHoursByClubId, dayWeek),
                );
              },
            ),
          );
  }

  void _addOpeningHour(List<OpeningHours> openingHoursByClubId, DaysWeek dayWeek) {
    openingHoursByClubId.add(
      OpeningHours(
        id: '${openingHoursByClubId.length + 1}',
        daysWeek: dayWeek,
        from: DateTime.now().add(const Duration(hours: 1)),
        to: DateTime.now().add(const Duration(hours: 2)),
        clubId: ref.watch(clubProvider).selectedClubId!,
      ),
    );
    setState(() {});
  }
}

class DayOpeningHourWidget extends StatefulWidget {
  const DayOpeningHourWidget({
    super.key,
    required this.items,
    required this.day,
    this.addTime,
  });

  final List items;
  final String day;
  final VoidCallback? addTime;

  @override
  State<DayOpeningHourWidget> createState() => _DayOpeningHourWidgetState();
}

class _DayOpeningHourWidgetState extends State<DayOpeningHourWidget> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
                value: isActive,
                onChanged: (value) => setState(() => isActive = value!)),
            Text(widget.day, style: style),
            const SizedBox(width: 50),
            IconButton(
              onPressed: widget.addTime,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16),
        widget.items.isEmpty || !isActive
            ? const Text('Un Available', style: style)
            : ListView.separated(
                shrinkWrap: true,
                itemCount: widget.items.length,
                separatorBuilder: (context, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) => FromToOpeningHoursWidget(
                    onDelete: () {
                      widget.items.removeAt(index);
                      setState(() {});
                    },
                    openingHours: widget.items[index]),
              ),
        const SizedBox(height: 40),
        const Divider(),
      ],
    );
  }
}
