import 'package:clients_digcoach/models/holiday.dart';
import 'package:flutter/material.dart';

import '../../core/constants/functions.dart';
import '../../repositories/holidays_repository.dart';
import 'from_to_field_holiday_widget.dart';

class HolidaysWidget extends StatefulWidget {
  const HolidaysWidget({super.key});

  @override
  State<HolidaysWidget> createState() => _HolidaysWidgetState();
}

class _HolidaysWidgetState extends State<HolidaysWidget> {
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return ListView(
      padding: padding(context),
      children: [
        Row(
          children: [
            Checkbox(
                value: isActive,
                onChanged: (value) => setState(() => isActive = value!)),
            const Text('Holidays', style: style),
            const SizedBox(width: 50),
            IconButton(
              onPressed: _addHoliday,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 30),
        holidays.isEmpty || !isActive
            ? const Text('Un Available', style: style)
            : ListView.separated(
                shrinkWrap: true,
                itemCount: holidays.length,
                separatorBuilder: (context, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) => FromToHolidaysWidget(
                    holiday: holidays[index],
                    onDelete: () {
                      holidays.removeAt(index);
                      setState(() {});
                    },
                  ),
              ),
      ],
    );
  }

  void _addHoliday() {
              if (isActive) {
                holidays.add(
                  Holiday(
                    id: '${holidays.length + 1}',
                    clubId: '1',
                    holidaysFrom: DateTime.now(),
                    holidaysTo: DateTime.now().add(const Duration(days: 3)),
                  ),
                );
                setState(() {});
              }
            }
}
