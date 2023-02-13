// import 'package:clients_digcoach/core/enums/days_week.dart';
// import 'package:clients_digcoach/providers/club_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../models/opening_hours.dart';
// import '../repositories/opening_hours_repository.dart';
//
// final openingHoursProvider =
//     ChangeNotifierProvider((ref) => OpeningHoursProvider());
//
// class OpeningHoursProvider extends ChangeNotifier {
//   final openingHoursRepository = OpeningHoursRepository();
//
//   List<OpeningHours> _openingHoursByClub = [];
//   bool _isLoading = false;
//
//   /// getters
//   List<OpeningHours> get openingHoursByDay => _openingHoursByClub;
//   bool get isLoading => _isLoading;
//
//   /// setters
//   void _loading(bool isLoading) {
//     _isLoading = isLoading;
//     notifyListeners();
//   }
//
//   /// methods
//
//
// }
