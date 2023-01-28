import 'coach_repository.dart';
import 'court_repository.dart';
import 'reservation_repository.dart';
import '../models/club.dart';

List<Club> _clubs = [
  Club(
    id: '1',
    name: 'Club 1',
    address: 'Address 1',
    phone: 'Phone 1',
    email: 'Email 1',
    website: 'Website 1',
    facebook: 'Facebook 1',
    twitter: 'Twitter 1',
    instagram: 'Instagram 1',
    image: 'Image 1',
    description: 'Description 1',
    coaches: coaches,
    courts: courts,
    reservations: reservations,
  ),
  Club(
    id: '2',
    name: 'Club 2',
    address: 'Address 2',
    phone: 'Phone 2',
    email: 'Email 2',
    website: 'Website 2',
    facebook: 'Facebook 2',
    twitter: 'Twitter 2',
    instagram: 'Instagram 2',
    image: 'Image 2',
    description: 'Description 2',
    coaches: coaches,
    courts: courts,
    reservations: reservations,
  ),
];

class ClubRepository {
  Future<Club> getClub(String id) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _clubs.firstWhere((club) => club.id == id),
    );
  }

  Future<List<Club>> getClubs() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => _clubs,
    );
  }
}
