import 'package:clients_digcoach/core/enums/days_week.dart';
import 'package:clients_digcoach/models/day.dart';
import 'package:clients_digcoach/repositories/opening_hours_repository.dart';

List<Day> days = [
  Day(
    id: '1',
    daysWeek: DaysWeek.sunday,
    checked: true,
    openingHours: openingHours,
    clubId: '1',
  ),
  Day(
    id: '2',
    daysWeek: DaysWeek.monday,
    checked: false,
    openingHours: openingHours,
    clubId: '1',
  ),
  Day(
    id: '3',
    daysWeek: DaysWeek.tuesday,
    checked: true,
    openingHours: openingHours,
    clubId: '1',
  ),
  Day(
    id: '4',
    daysWeek: DaysWeek.wednesday,
    checked: true,
    openingHours: openingHours,
    clubId: '1',
  ),
  Day(
    id: '5',
    daysWeek: DaysWeek.thursday,
    checked: true,
    openingHours: openingHours,
    clubId: '1',
  ),
  Day(
    id: '6',
    daysWeek: DaysWeek.friday,
    checked: false,
    openingHours: openingHours,
    clubId: '1',
  ),
  Day(
    id: '7',
    daysWeek: DaysWeek.saturday,
    checked: false,
    openingHours: openingHours,
    clubId: '1',
  ),
 Day(
    id: '8',
    daysWeek: DaysWeek.saturday,
    checked: false,
    openingHours: openingHours,
    clubId: '1',
  ),
 Day(
    id: '9',
    daysWeek: DaysWeek.saturday,
    checked: true,
    openingHours: openingHours,
    clubId: '1',
  ),
];
