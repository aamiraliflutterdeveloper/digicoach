import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../screens/clubs/add_club_screen.dart';
import 'clubs/club_data_grid_widget.dart';

class ClubCoachCardWidget extends StatelessWidget {
  const ClubCoachCardWidget({super.key, required this.isCoach});

  final bool isCoach;

  @override
  Widget build(BuildContext context) => Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20).copyWith(
            topLeft: const Radius.circular(0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(flex: 5),
                  Text(
                    isCoach ? 'Coaches' : 'Clubs',
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 4),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: kPrimaryColor,
                    ),
                    label: Text(isCoach ? 'New Coach' : 'New Club'),
                    icon: const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddClubScreen(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                isCoach
                    ? 'Modify or create new coaches'
                    : 'Modify or create new clubs',
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const Expanded(child: ClubDataGridWidget()),
            ],
          ),
        ),
      );
}
