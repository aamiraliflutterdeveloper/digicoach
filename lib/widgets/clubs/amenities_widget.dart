import 'package:clients_digcoach/data/amenities.dart';
import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/models/club/amenity.dart';
import 'package:clients_digcoach/providers/add_club_provider.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmenitiesWidget extends ConsumerStatefulWidget {
  const AmenitiesWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AmenitiesWidgetState();
}

class _AmenitiesWidgetState extends ConsumerState<AmenitiesWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Wrap(children: allAmenities.map(buildAmenity).toList()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () async {
                  final club = ref.read(addClubProvider).club;
                  ref.read(clubProvider).addClub(club);

                  Scaffold.of(context).closeEndDrawer();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildAmenity(Amenity amenity) {
    final amenities = ref.watch(addClubProvider).club.amenities;
    final isSelected = amenities.contains(amenity);
    final color = isSelected ? AppColors.primaryColor : Colors.grey;

    return GestureDetector(
      onTap: () => ref.read(addClubProvider).toggleAmenity(amenity),
      child: Container(
        width: 150,
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color),
        ),
        child: Column(
          children: [
            Icon(amenity.icon, color: color),
            const SizedBox(height: 8),
            Text(
              amenity.text,
              style: TextStyle(
                color: color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
