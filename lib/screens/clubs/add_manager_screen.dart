import 'package:clients_digcoach/providers/add_club_provider.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/utils/widget_utils.dart';
import 'package:clients_digcoach/widgets/clubs/amenities_widget.dart';
import 'package:clients_digcoach/widgets/clubs/courts_widget.dart';
import 'package:clients_digcoach/widgets/clubs/general_info_widget.dart';
import 'package:clients_digcoach/widgets/clubs/holidays_widget.dart';
import 'package:clients_digcoach/widgets/clubs/opening_hours_widget.dart';
import 'package:clients_digcoach/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddManagerScreen extends ConsumerStatefulWidget {
  const AddManagerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddManagerScreenState();
}

class _AddManagerScreenState extends ConsumerState<AddManagerScreen> {
  @override
  Widget build(BuildContext context) {
    const tabs = [
      'General Info',
    ];
    const widgets = [
      GeneralInfoWidget(),
    ];
    return Scaffold(
      body: ListView(
        padding: WidgetUtils.padding(context, maxPadding: 16),
        children: [
          buildTabs(tabs),
          const SizedBox(height: 24),
          widgets[ref.watch(addClubProvider).tabIndex],
        ],
      ),
    );
  }

  Widget buildTabs(List<String> tabs) => Row(
        children: WidgetUtils.addSpaceBetween(
          children: List.generate(
            tabs.length,
            (index) => Expanded(
              child: TabWidget(
                index: index,
                title: tabs[index],
                currentIndex: ref.watch(addClubProvider).tabIndex,
                onTap: () => ref.read(addClubProvider).tabIndex = index,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          space: const SizedBox(width: 8),
        ),
      );
}
