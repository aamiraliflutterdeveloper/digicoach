import 'package:brasil_fields/brasil_fields.dart';
import 'package:clients_digcoach/models/opening_hours.dart';
import 'package:clients_digcoach/repositories/opening_hours_repository.dart';
import 'package:clients_digcoach/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/functions.dart';
import 'from_to_field_widget.dart';

class OpeningHoursWidget extends StatefulWidget {
  const OpeningHoursWidget({super.key});

  @override
  State<OpeningHoursWidget> createState() => _OpeningHoursWidgetState();
}

class _OpeningHoursWidgetState extends State<OpeningHoursWidget> {
  final List<TextEditingController> fromControllers = [];
  final List<TextEditingController> toControllers = [];

  // final mondayToController = TextEditingController();
  DateTime parsedDateFrom = DateTime.parse('2022-03-20 09:00');
  DateTime parsedDateTo = DateTime.parse('2022-03-20 20:00');

  List<OpeningHours> openHours = [];
  bool isActive = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
    return ListView(
      padding: padding(context),
      children: [
        Row(
          children: [
            Checkbox(
                value: isActive,
                onChanged: (value) => setState(() => isActive = value!)),
            const Text('Sunday', style: style),
            const SizedBox(width: 50),
            IconButton(
              onPressed: () {
                if (isActive) {
                  setState(() {
                    fromControllers.add(TextEditingController(
                        text: UtilData.obterHoraHHMM(parsedDateFrom
                            .add(Duration(hours: openHours.length + 1)))));
                    toControllers.add(TextEditingController(
                        text: UtilData.obterHoraHHMM(parsedDateTo)));
                  });

                  openHours.add(
                    OpeningHours(
                      id: '${openHours.length + 1}',
                      dayId: '1',
                      from: DateTime.parse(
                              '2022-03-20 ${fromControllers.first.text}')
                          .add(const Duration(hours: 1)),
                      to: DateTime.parse(
                          '2022-03-21 ${toControllers.first.text}'),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 30),
        openHours.isEmpty || !isActive
            ? const Text('Un Available', style: style)
            : ListView.separated(
                shrinkWrap: true,
                itemCount: openHours.length,
                // toControllers.length,
                // openingHours.where((element) => element.dayId == '1').length,
                // openingHours.length,
                separatorBuilder: (context, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) => FromToFieldWidget(
                  toController: toControllers[index],
                  fromController: fromControllers[index],
                  onDelete: () {
                    openHours.removeAt(index);
                    setState(() {});
                  },
                ),
              ),
      ],
    );
  }
}
