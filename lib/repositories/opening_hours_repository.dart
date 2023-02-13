import 'package:clients_digcoach/core/enums/days_week.dart';

import '../models/opening_hours.dart';

List<OpeningHours> openingHours = [
  OpeningHours(
    id: '1',
    daysWeek: DaysWeek.saturday,
    from: DateTime.now(),
    to: DateTime.now().add(const Duration(hours: 1)), clubId: '1',
   ),
  OpeningHours(
    id: '2',
    daysWeek: DaysWeek.sunday,
    from: DateTime.now(),
    to: DateTime.now().add(const Duration(hours: 2)), clubId: '1',
  ),
  OpeningHours(
    id: '8',
    daysWeek: DaysWeek.sunday,
    from: DateTime.now(),
    to: DateTime.now().add(const Duration(hours: 2)), clubId: '1',
  ),
  OpeningHours(
    id: '3',
    daysWeek: DaysWeek.monday,
    from: DateTime.now(),
    to: DateTime.now().add(const Duration(hours: 3)), clubId: '1',
  ),
  OpeningHours(
    id: '4',
    daysWeek: DaysWeek.tuesday,
    from: DateTime.now(),
    to: DateTime.now().add(const Duration(hours: 4)), clubId: '1',
  ),
  OpeningHours(
    id: '5',
    daysWeek: DaysWeek.wednesday,
    from: DateTime.now(),
    to: DateTime.now().add(const Duration(hours: 5)), clubId: '1',
  ),
  OpeningHours(
    id: '6',
    daysWeek: DaysWeek.thursday,
    from: DateTime.now(),
    to: DateTime.now().add(const Duration(hours: 6)), clubId: '1',
  ),
  OpeningHours(
    id: '7',
    daysWeek: DaysWeek.friday,
    from: DateTime.now(),
    to: DateTime.now().add(const Duration(hours: 7)), clubId: '1',
  ),
];

