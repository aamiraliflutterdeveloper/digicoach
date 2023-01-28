import '../models/coach.dart';

List<Coach> coaches = [
  Coach(
    id: '1',
    name: 'Coach 1',
    image: 'Image 1',
    description: 'Description 1',
    address: 'Address 1',
    phone: 'Phone 1',
  ),
  Coach(
    id: '2',
    name: 'Coach 2',
    image: 'Image 2',
    description: 'Description 2',
    address: 'Address 2',
    phone: 'Phone 2',
  ),
  Coach(
    id: '3',
    name: 'Coach 3',
    image: 'Image 3',
    description: 'Description 3',
    address: 'Address 3',
    phone: 'Phone 3',
  ),
  Coach(
    id: '4',
    name: 'Coach 4',
    image: 'Image 4',
    description: 'Description 4',
    address: 'Address 4',
    phone: 'Phone 4',
  ),
  Coach(
    id: '5',
    name: 'Coach 5',
    image: 'Image 5',
    description: 'Description 5',
    address: 'Address 5',
    phone: 'Phone 5',
  ),
];

class CoachRepository {
  Future<Coach> getCoach(String id) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => coaches.firstWhere((coach) => coach.id == id),
    );
  }

  Future<List<Coach>> getCoaches() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => coaches,
    );
  }
}
