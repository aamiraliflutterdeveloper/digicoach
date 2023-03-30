import 'package:clients_digcoach/models/court.dart';
import 'package:clients_digcoach/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/add_club_provider.dart';
import '../text_form_field_widget.dart';

class CourtsWidget extends ConsumerStatefulWidget {
  const CourtsWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourtsWidgetState();
}

class _CourtsWidgetState extends ConsumerState<CourtsWidget> {
  int courtIndex = 0;

  @override
  Widget build(BuildContext context) {
    final courts = ref.watch(addClubProvider).club.courts;
    final selectedCourt = courts[courtIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCourtsTab(courts),
        const SizedBox(height: 20),
        buildCourt(selectedCourt),
      ],
    );
  }

  Widget buildCourt(Court court) {
    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    const sports = ['Padel', 'Tennis'];
    const types = ['Indoor', 'Outdoor', 'Roofed Outdoor'];
    const closures = ['Crystal', 'Wall'];
    const numberOfPlayer = ['Double', 'Single'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Name', style: style),
        const SizedBox(height: 10),
        NewTextFormFieldWidget(
          hintText: 'Name',
          text: court.name,
          isRequired: true,
          onChanged: (name) {
            final newCourt = court.copy(name: name);
            ref.read(addClubProvider).updateCourt(newCourt);
          },
        ),
        const SizedBox(height: 30),
        const Text('Description', style: style),
        const SizedBox(height: 10),
        NewTextFormFieldWidget(
          hintText: 'Description',
          text: court.description,
          maxLines: 5,
          onChanged: (description) {
            final newCourt = court.copy(description: description);
            ref.read(addClubProvider).updateCourt(newCourt);
          },
        ),
        const SizedBox(height: 30),
        buildOutsideCourtEnabled(court, style),
        const SizedBox(height: 30),
        const Text('Sport', style: style),
        const SizedBox(height: 20),
        ChoiceWidget(
          titles: sports,
          currentIndex: court.sport,
          onChangedIndex: (sport) {
            final newCourt = court.copy(sport: sport);
            ref.read(addClubProvider).updateCourt(newCourt);
          },
        ),
        const SizedBox(height: 30),
        const Text('Type', style: style),
        const SizedBox(height: 20),
        ChoiceWidget(
          titles: types,
          currentIndex: court.type,
          onChangedIndex: (type) {
            final newCourt = court.copy(type: type);
            ref.read(addClubProvider).updateCourt(newCourt);
          },
        ),
        const SizedBox(height: 30),
        const Text('Closure', style: style),
        const SizedBox(height: 20),
        ChoiceWidget(
          titles: closures,
          currentIndex: court.closure,
          onChangedIndex: (closure) {
            final newCourt = court.copy(closure: closure);
            ref.read(addClubProvider).updateCourt(newCourt);
          },
        ),
        const SizedBox(height: 30),
        const Text('Number of Players', style: style),
        const SizedBox(height: 20),
        ChoiceWidget(
          titles: numberOfPlayer,
          currentIndex: court.numberPlayers,
          onChangedIndex: (numberPlayers) {
            final newCourt = court.copy(numberPlayers: numberPlayers);
            ref.read(addClubProvider).updateCourt(newCourt);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              child: const Text('Next'),
              onPressed: () async {
                ref.read(addClubProvider).tabIndex = 4;
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildOutsideCourtEnabled(Court court, TextStyle style) =>
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          final newCourt =
              court.copy(outsideCourtEnable: !court.outsideCourtEnable);
          ref.read(addClubProvider).updateCourt(newCourt);
        },
        child: Row(
          children: [
            Checkbox(
              value: court.outsideCourtEnable,
              onChanged: (outsideCourtEnable) {
                final newCourt =
                    court.copy(outsideCourtEnable: outsideCourtEnable);
                ref.read(addClubProvider).updateCourt(newCourt);
              },
            ),
            Text('Is outside court?', style: style),
          ],
        ),
      );

  Widget buildCourtsTab(List<Court> courts) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              final provider = ref.read(addClubProvider);
              provider.addCourt();

              final courts = provider.club.courts;
              final index = courts.length - 1;
              updateCourtIndex(index);
            },
            icon: const Icon(Icons.add, size: 30),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: courts.length,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final court = courts[index];
                return TabWidget(
                  index: index,
                  currentIndex: courtIndex,
                  title: court.name,
                  onTap: () => updateCourtIndex(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateCourtIndex(int index) {
    setState(() {
      courtIndex = index;
    });
  }
}

class ChoiceWidget extends StatelessWidget {
  const ChoiceWidget({
    super.key,
    required this.currentIndex,
    required this.titles,
    required this.onChangedIndex,
  });

  final int currentIndex;
  final List<String> titles;
  final ValueChanged<int> onChangedIndex;

  @override
  Widget build(BuildContext context) => Row(
        children: List.generate(
          titles.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TabWidget(
              index: index,
              currentIndex: currentIndex,
              title: titles[index],
              onTap: () => onChangedIndex(index),
            ),
          ),
        ),
      );
}
