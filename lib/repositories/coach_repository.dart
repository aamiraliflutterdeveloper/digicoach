
import '../models/coach.dart';

List<Coach> coaches =const [
  Coach(
    id: '1',
    clubId: '1',
    name: 'Coach 1',
    image:
        'https://images.unsplash.com/photo-1613685044678-0a9ae422cf5a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGZpdG5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    description: 'Description 1',
    address: 'Address 1',
    phone: 'Phone 1',
  ),
  Coach(
    id: '2',
    clubId: '2',
    name: 'Coach 2',
    image:
        'https://images.unsplash.com/photo-1549476464-37392f717541?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
    description: 'Description 2',
    address: 'Address 2',
    phone: 'Phone 2',
  ),
  Coach(
    id: '3',
    clubId: '1',
    name: 'Coach 3',
    image:
        'https://images.unsplash.com/photo-1613685044678-0a9ae422cf5a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGZpdG5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    description: 'Description 3',
    address: 'Address 3',
    phone: 'Phone 3',
  ),
  Coach(
    id: '4',
    clubId: '2',
    name: 'Coach 4',
    image:
        'https://images.unsplash.com/photo-1549476464-37392f717541?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
    description: 'Description 4',
    address: 'Address 4',
    phone: 'Phone 4',
  ),
  Coach(
    id: '5',
    clubId: '1',
    name: 'Coach 5',
    image:
        'https://images.unsplash.com/photo-1613685044678-0a9ae422cf5a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzF8fGZpdG5lc3N8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    description: 'Description 5',
    address: 'Address 5',
    phone: 'Phone 5',
  ),
];

class CoachRepository {
  Future<List<Coach>> getCoachesByClubId(String id) async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => coaches.where((coach) => coach.clubId == id).toList(),
    );
  }

  // Future<String> getCoachId() async {
  //   return Future.delayed(
  //     const Duration(seconds: 1),
  //     () => coaches.first.id,
  //   );
  // }

  Future<List<Coach>> getCoaches() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () => coaches,
    );
  }
}
