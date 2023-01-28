// Club model for tennis club
import 'package:clients_digcoach/models/reservation.dart';

import 'coach.dart';
import 'court.dart';

class Club {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String facebook;
  final String twitter;
  final String instagram;
  final String image;
  final String description;
  final List<Court> courts;
  final List<Coach> coaches;
  final List<Reservation> reservations;

  Club(
      {required this.id,
      required this.name,
      required this.address,
      required this.phone,
      required this.email,
      required this.website,
      required this.facebook,
      required this.twitter,
      required this.instagram,
      required this.image,
      required this.description,
      required this.courts,
      required this.coaches,
      required this.reservations});

  factory Club.fromJson(Map<String, dynamic> json) {
    return Club(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      website: json['website'],
      facebook: json['facebook'],
      twitter: json['twitter'],
      instagram: json['instagram'],
      image: json['image'],
      description: json['description'],
      courts: json['courts'] != null
          ? (json['courts'] as List).map((e) => Court.fromJson(e)).toList()
          : [],
      coaches: json['coaches'] != null
          ? (json['coaches'] as List).map((e) => Coach.fromJson(e)).toList()
          : [],
      reservations: json['reservations'] != null
          ? (json['reservations'] as List)
              .map((e) => Reservation.fromJson(e))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'email': email,
      'website': website,
      'facebook': facebook,
      'twitter': twitter,
      'instagram': instagram,
      'image': image,
      'description': description,
      'courts': courts.map((e) => e.toJson()).toList(),
      'coaches': coaches.map((e) => e.toJson()).toList(),
      'reservations': reservations.map((e) => e.toJson()).toList(),
    };
  }
}
