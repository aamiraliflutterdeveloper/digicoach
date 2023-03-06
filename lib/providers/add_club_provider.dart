import 'package:clients_digcoach/data/clubs.dart';
import 'package:clients_digcoach/models/club/amenity.dart';
import 'package:clients_digcoach/models/club/club.dart';
import 'package:clients_digcoach/models/club/holiday.dart';
import 'package:clients_digcoach/models/club/opening_hours.dart';
import 'package:clients_digcoach/models/court.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addClubProvider = ChangeNotifierProvider((ref) => AddClubProvider());

class AddClubProvider extends ChangeNotifier {
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  Club _club = defaultClub(clubId: 1);
  Club get club => _club;
  set club(Club club) {
    _club = club;
    notifyListeners();
  }

  void toggleAmenity(Amenity amenity) {
    final isSelected = club.amenities.contains(amenity);
    final newAmenities = isSelected
        ? (club.amenities..remove(amenity))
        : (club.amenities..add(amenity));

    _club = _club.copyWith(amenities: newAmenities);

    notifyListeners();
  }

  void addCourt() {
    final courtNumber = club.courts.length + 1;

    final newCourt = Court(
      id: '$courtNumber',
      clubId: club.id,
      name: 'Court $courtNumber',
      description: '',
      courtNumber: courtNumber,
    );
    final newCourts = List.of(club.courts)..add(newCourt);
    club = club.copyWith(courts: newCourts);

    notifyListeners();
  }

  void updateCourt(Court court) {
    final index = club.courts.indexWhere((oldCourt) => oldCourt.id == court.id);
    final newCourts = List.of(club.courts);
    newCourts[index] = court;

    club = club.copyWith(courts: newCourts);
    notifyListeners();
  }

  void updateOpeningHours(OpeningHours openingHours) {
    final index = club.openingHours.indexWhere(
        (oldOpeningHours) => oldOpeningHours.day == openingHours.day);
    final newOpeningHours = List.of(club.openingHours);
    newOpeningHours[index] = openingHours;

    club = club.copyWith(openingHours: newOpeningHours);
    notifyListeners();
  }

  void addHoliday() {
    final holidays = club.holidays;
    final newHoliday = holidays.isEmpty
        ? Holiday.standard()
        : Holiday.standard(
            from: holidays.last.to,
            fromAdd: const Duration(days: 7),
            toAdd: const Duration(days: 14),
          );

    final newHolidays = List.of(holidays)..add(newHoliday);

    club = club.copyWith(holidays: newHolidays);
    notifyListeners();
  }

  void removeAllHolidays() {
    club = club.copyWith(holidays: []);

    notifyListeners();
  }

  void removeHoliday(int index) {
    final newHolidays = List.of(club.holidays)..removeAt(index);

    club = club.copyWith(holidays: newHolidays);
    notifyListeners();
  }
}
