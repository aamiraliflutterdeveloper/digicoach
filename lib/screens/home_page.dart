import 'package:clients_digcoach/screens/day_vew_screeen.dart';
import 'package:clients_digcoach/screens/heat_map/heat_map_page.dart';
import 'package:clients_digcoach/screens/weeK_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _widgetOptions = [
    {'title': 'Heat Map', 'widget': const HeatMapPage()},
    {'title': 'Day View', 'widget': const DayViewScreen()},
    {'title': 'Week View', 'widget': const WeekViewScreen()},
    {'title': 'Month View', 'widget': const HeatMapPage()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DigCoach'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: _widgetOptions
                .map(
                  (e) => MenuWidget(
                    title: e['title'],
                    selectedIndex: _selectedIndex,
                    index: _widgetOptions.indexOf(e),
                    onTap: () {
                      setState(() {
                        _selectedIndex = _widgetOptions.indexOf(e);
                      });
                    },
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: _widgetOptions[_selectedIndex]['widget'],
          ),
        ],
      ),
    );
  }
}

class MenuWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final int selectedIndex;
  final int index;

  const MenuWidget(
      {super.key,
      required this.title,
      required this.onTap,
      required this.selectedIndex,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        color: selectedIndex == index ? Colors.grey : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Text(title),
        ),
      ),
    );
  }
}
