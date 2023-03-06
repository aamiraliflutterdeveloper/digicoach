import 'package:flutter/material.dart';

class Amenity {
  final String text;
  final IconData icon;

  const Amenity({
    required this.text,
    required this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Amenity &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          icon == other.icon;

  @override
  int get hashCode => text.hashCode ^ icon.hashCode;
}
