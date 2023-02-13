import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/widgets/clubs/amenities_widget.dart';
import 'package:clients_digcoach/widgets/clubs/courts_widget.dart';
import 'package:clients_digcoach/widgets/clubs/general_info_widget.dart';
import 'package:clients_digcoach/widgets/clubs/holidays_widget.dart';
import 'package:clients_digcoach/widgets/clubs/opening_hours_widget.dart';
import 'package:clients_digcoach/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/opening_hours_provider.dart';

class AddClubScreen extends ConsumerStatefulWidget {
  const AddClubScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddClubScreenState();
}

class _AddClubScreenState extends ConsumerState<AddClubScreen> {

  @override
  Widget build(BuildContext context) {
    const titles = [
      'General Info',
      'Opening Hours',
      'Holidays',
      'Courts',
      'Amenities',
    ];
    const widgets = [
      GeneralInfoWidget(),
      OpeningHoursWidget(),
      HolidaysWidget(),
      CourtsWidget(),
      AmenitiesWidget(),
    ];
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                ...List.generate(
                  titles.length,
                  (index) => Expanded(
                    child: TabWidget(
                      index: index,
                      title: titles[index],
                      currentIndex:ref.watch(clubProvider).addClubCurrentTap ,
                      onTap: () => ref.read(clubProvider).addClubCurrentTap  = index,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(flex: 6, child: widgets[ref.watch(clubProvider).addClubCurrentTap]),
          ],
        ),
      ),
    );
  }
}
