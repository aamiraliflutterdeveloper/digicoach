import 'package:clients_digcoach/models/club/amenity.dart';
import 'package:flutter/material.dart';

const defaultAmenities = [
  Amenities.freeParking,
  Amenities.ballsRenting,
  Amenities.changeRoom,
  Amenities.coffeeShop,
  Amenities.snackBar,
];

const allAmenities = [
  Amenities.freeParking,
  Amenities.privateParking,
  Amenities.ballsRenting,
  Amenities.racketsRenting,
  Amenities.store,
  Amenities.changeRoom,
  Amenities.lockers,
  Amenities.wifi,
  Amenities.coffeeShop,
  Amenities.snackBar,
  Amenities.restaurant,
  Amenities.vendingMachine,
  Amenities.playPark,
  Amenities.disableAccess,
];

class Amenities {
  static const freeParking =
      Amenity(text: 'freeParking', icon: Icons.car_repair);
  static const privateParking =
      Amenity(text: 'privateParking', icon: Icons.local_parking);
  static const ballsRenting =
      Amenity(text: 'ballsRenting', icon: Icons.sports_baseball);
  static const racketsRenting =
      Amenity(text: 'racketsRenting', icon: Icons.sports_tennis);
  static const store = Amenity(text: 'store', icon: Icons.store);
  static const changeRoom =
      Amenity(text: 'changeRoom', icon: Icons.meeting_room_sharp);
  static const lockers = Amenity(text: 'lockers', icon: Icons.safety_check);
  static const wifi = Amenity(text: 'wifi', icon: Icons.wifi);
  static const coffeeShop = Amenity(text: 'coffeeShop', icon: Icons.coffee);
  static const snackBar = Amenity(text: 'snackBar', icon: Icons.cookie);
  static const restaurant = Amenity(text: 'restaurant', icon: Icons.restaurant);
  static const vendingMachine =
      Amenity(text: 'vendingMachine', icon: Icons.electric_bolt);
  static const playPark = Amenity(text: 'playPark', icon: Icons.park);
  static const disableAccess =
      Amenity(text: 'disableAccess', icon: Icons.disabled_by_default);
}
