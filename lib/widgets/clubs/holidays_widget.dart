import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/add_club_provider.dart';
import 'from_to_field_holiday_widget.dart';

class HolidaysWidget extends ConsumerStatefulWidget {
  const HolidaysWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HolidaysWidgetState();
}

class _HolidaysWidgetState extends ConsumerState<HolidaysWidget> {
  @override
  Widget build(BuildContext context) {
    final holidays = ref.watch(addClubProvider).club.holidays;
    final isActive = holidays.isNotEmpty;

    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: isActive,
              onChanged: (isActive) {
                if (isActive!) {
                  addHoliday();
                } else {
                  removeAllHolidays();
                }
              },
            ),
            const Text('Holidays', style: style),
            const SizedBox(width: 50),
            IconButton(
              onPressed: addHoliday,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 24),
        holidays.isEmpty || !isActive
            ? const Text('Unavailable', style: style)
            : ListView.separated(
                shrinkWrap: true,
                itemCount: holidays.length,
                separatorBuilder: (context, _) => const SizedBox(height: 20),
                itemBuilder: (context, index) => FromToHolidaysWidget(
                  holiday: holidays[index],
                  onDelete: () => removeHoliday(index),
                ),
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () async {
                ref.read(addClubProvider).tabIndex = 3;
              },
            ),
          ],
        ),
      ],
    );
  }

  void addHoliday() => ref.read(addClubProvider).addHoliday();

  void removeAllHolidays() => ref.read(addClubProvider).removeAllHolidays();

  void removeHoliday(int index) =>
      ref.read(addClubProvider).removeHoliday(index);
}
