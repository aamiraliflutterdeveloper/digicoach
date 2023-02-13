import 'package:clients_digcoach/core/constants/functions.dart';
import 'package:clients_digcoach/providers/court_provider.dart';
import 'package:clients_digcoach/widgets/tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../text_form_field_widget.dart';

class CourtsWidget extends ConsumerStatefulWidget {
  const CourtsWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CourtsWidgetState();
}

class _CourtsWidgetState extends ConsumerState<CourtsWidget> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  int courtCurrentIndex = 0;
  int sportCurrentIndex = 0;
  int typeCurrentIndex = 0;
  int closureCurrentIndex = 0;
  int playersNumberCurrentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final courts = ref.watch(courtProvider).courtsByClubId;
    const style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    const sports = ['Padel', 'tennis'];
    const types = ['Indoor', 'Outdoor', 'Roofed Outdoor'];
    const closures = ['Crystal', 'Wall'];
    const numberOfPlayer = ['Double', 'Single'];

    return ListView(
      padding: padding(context),
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add, size: 30),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: courts.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemBuilder: (context, index) => TabWidget(
                    index: index,
                    currentIndex: courtCurrentIndex,
                    title: courts[index].name,
                    onTap: () => setState(() => courtCurrentIndex = index),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
        const Text('Name', style: style),
        const SizedBox(height: 10),
        TextFormFieldWidget(
          hintText: 'Name',
          controller: nameController,
          isRequired: true,
        ),
        const SizedBox(height: 30),
        const Text('Description', style: style),
        const SizedBox(height: 10),
        TextFormFieldWidget(
          hintText: 'Description',
          controller: descriptionController,
          maxLines: 5,
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (value) {},
            ),
            const Text('Is outside court?', style: style),
          ],
        ),
        const SizedBox(height: 30),
        const Text('Sport', style: style),
        const SizedBox(height: 20),
        ChoiceWidget(titles: sports, currentIndex: sportCurrentIndex),
        const SizedBox(height: 30),
        const Text('Type', style: style),
        const SizedBox(height: 20),
        ChoiceWidget(titles: types, currentIndex: typeCurrentIndex),
        const SizedBox(height: 30),
        const Text('Closure', style: style),
        const SizedBox(height: 20),
        ChoiceWidget(titles: closures, currentIndex: closureCurrentIndex),
        const SizedBox(height: 30),
        const Text('Number of Players', style: style),
        const SizedBox(height: 20),
        ChoiceWidget(
            titles: numberOfPlayer, currentIndex: playersNumberCurrentIndex),
      ],
    );
  }
}

class ChoiceWidget extends StatefulWidget {
  const ChoiceWidget({super.key, this.currentIndex, required this.titles});

  final int? currentIndex;
  final List<String> titles;

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.currentIndex ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Row(
        children: List.generate(
          widget.titles.length,
          (index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TabWidget(
              index: index,
              currentIndex: currentIndex,
              title: widget.titles[index],
              onTap: () => setState(() => currentIndex = index),
            ),
          ),
        ),
      );
}
