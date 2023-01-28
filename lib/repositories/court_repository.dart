import 'package:clients_digcoach/models/court.dart';

List<Court> courts = [
  Court(
    id: '1',
    clubId: '1',
    name: 'Court 1',
    address: 'Address 1',
    image: 'Image 1',
    description: 'Description 1',
  ),
  Court(
    id: '2',
    clubId: '1',
    name: 'Court 2',
    address: 'Address 2',
    image: 'Image 2',
    description: 'Description 2',
  ),
  Court(
    id: '3',
    clubId: '1',
    name: 'Court 3',
    address: 'Address 3',
    image: 'Image 3',
    description: 'Description 3',
  ),
  Court(
    id: '4',
    clubId: '1',
    name: 'Court 4',
    address: 'Address 4',
    image: 'Image 4',
    description: 'Description 4',
  ),
  Court(
    id: '5',
    clubId: '1',
    name: 'Court 5',
    address: 'Address 5',
    image: 'Image 5',
    description: 'Description 5',
  ),
  Court(
    id: '6',
    clubId: '1',
    name: 'Court 6',
    address: 'Address 6',
    image: 'Image 6',
    description: 'Description 6',
  ),
  Court(
    id: '7',
    clubId: '1',
    name: 'Court 7',
    address: 'Address 7',
    image: 'Image 7',
    description: 'Description 7',
  ),
  Court(
    id: '8',
    clubId: '1',
    name: 'Court 8',
    address: 'Address 8',
    image: 'Image 8',
    description: 'Description 8',
  ),
  Court(
    id: '9',
    clubId: '1',
    name: 'Court 9',
    address: 'Address 9',
    image: 'Image 9',
    description: 'Description 9',
  ),
  Court(
    id: '10',
    clubId: '1',
    name: 'Court 10',
    address: 'Address 10',
    image: 'Image 10',
    description: 'Description 10',
  ),
];

class CourtRepository {
  Future<List<Court>> getCourts() async {
    Future.delayed(const Duration(seconds: 2));
    return courts;
  }

  Future<List<Court>> getCourtsByClubId(String clubId) async {
    Future.delayed(const Duration(seconds: 2));
    return courts.where((court) => court.clubId == clubId).toList();
  } 
}
