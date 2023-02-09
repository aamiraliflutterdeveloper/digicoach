import 'package:clients_digcoach/models/general_info.dart';
import 'package:clients_digcoach/repositories/days_repository.dart';

import 'coach_repository.dart';
import 'court_repository.dart';
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
      images: ['images'],
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
      images: ['images'],
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
      images: ['images'],
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
  // Future<Club> getClub(String id) async {
  //   return Future.delayed(
  //     const Duration(seconds: 1),
  //     () => clubs.firstWhere((club) => club.id == id),
  //   );
  // }

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

  Future<List<Club>> getClubs() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => clubs,
    );
  }
}
