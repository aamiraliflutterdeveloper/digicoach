import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../screens/clubs/add_club_screen.dart';
import 'club_data_grid_widget.dart';

class ClubCardWidget extends StatelessWidget {
  const ClubCardWidget({super.key});

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
                  const Text(
                    'Clubs',
                    style: TextStyle(
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
                    label: const Text('New Club'),
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
                        ),),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text(
                'Modify or create new clubs',
                style: TextStyle(
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
