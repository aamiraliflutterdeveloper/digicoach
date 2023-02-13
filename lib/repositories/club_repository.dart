import 'package:clients_digcoach/models/day.dart';
import 'package:clients_digcoach/models/general_info.dart';
import 'package:clients_digcoach/repositories/days_repository.dart';

import '../core/enums/days_week.dart';
import '../models/opening_hours.dart';
import 'coach_repository.dart';
import 'court_repository.dart';
import 'opening_hours_repository.dart';
import 'reservation_repository.dart';
import '../models/club.dart';

List<Club> clubs = [
  Club(
    id: '1',
    coaches: coaches,
    courts: courts,
    reservations: reservations,
    days: days,
    generalInfo: const GeneralInfo(
      id: '1',
      name: 'club 1',
      ceoName: 'ceo',
      surName: 'sur name ceo',
      phone: 'phone',
      description: 'description',
      street: 'street',
      city: 'city',
      country: 'country',
      postalCode: 'postalCode',
      url: 'url',
      email: 'email',
      instagram: 'instagram',
      facebook: 'facebook',
      tiktok: 'tiktok',
      twitter: 'twitter',
      images: ['https://images.unsplash.com/photo-1613685044678-0a9ae422cf5a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGZpdG5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'],
    ),
    holidays: [],
    amenities: [
      'freeParking',
      'privateParking',
      'ballsRenting',
      'racketsRenting',
      'store',
      'changeRoom',
      'lockers',
      'wifi',
      'coffeeShop',
      'snackBar',
      'restaurant',
      'vendingMachine',
      'playPark',
      'disableAccess',
    ],
  ),
  Club(
    id: '2',
    coaches: coaches,
    courts: courts,
    reservations: reservations,
    days: days,
    generalInfo: const GeneralInfo(
      id: '2',
      name: 'club 2',
      ceoName: 'ceo',
      surName: 'sur name ceo',
      phone: 'phone',
      description: 'description',
      street: 'street',
      city: 'city',
      country: 'country',
      postalCode: 'postalCode',
      url: 'url',
      email: 'email',
      instagram: 'instagram',
      facebook: 'facebook',
      tiktok: 'tiktok',
      twitter: 'twitter',
      images: ['https://images.unsplash.com/photo-1613685044678-0a9ae422cf5a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGZpdG5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'],
    ),
    holidays: [],
    amenities: [
      'freeParking',
      'privateParking',
      'ballsRenting',
      'racketsRenting',
      'store',
      'changeRoom',
      'lockers',
      'wifi',
      'coffeeShop',
      'snackBar',
      'restaurant',
      'vendingMachine',
      'playPark',
      'disableAccess',
    ],
  ),
  Club(
    id: '3',
    coaches: coaches,
    courts: courts,
    reservations: reservations,
    days: days,
    generalInfo: const GeneralInfo(
      id: '3',
      name: 'club 3',
      ceoName: 'ceo',
      surName: 'sur name ceo',
      phone: 'phone',
      description: 'description',
      street: 'street',
      city: 'city',
      country: 'country',
      postalCode: 'postalCode',
      url: 'url',
      email: 'email',
      instagram: 'instagram',
      facebook: 'facebook',
      tiktok: 'tiktok',
      twitter: 'twitter',
      images: ['https://images.unsplash.com/photo-1613685044678-0a9ae422cf5a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGZpdG5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60'],
    ),
    holidays: [],
    amenities: [
      'freeParking',
      'privateParking',
      'ballsRenting',
      'racketsRenting',
      'store',
      'changeRoom',
      'lockers',
      'wifi',
      'coffeeShop',
      'snackBar',
      'restaurant',
      'vendingMachine',
      'playPark',
      'disableAccess',
    ],
  ),
];

class ClubRepository {


  Future<String> getClubId() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => clubs.first.id,
    );
  }

  Future<void> removeClubById(String id) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => clubs.removeWhere((element) => element.id == id),
    );
  }

  Future<void> addClub(Club club) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => clubs.add(club),
    );
  }

  Future<List<Club>> getClubs() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => clubs,
    );
  }
  Future<List<OpeningHours>> getOpeningHoursByClubId(String id)async{
    Future.delayed(const Duration(seconds: 1));
    return openingHours.where((element) => element.clubId == id).toList();
  }

}
