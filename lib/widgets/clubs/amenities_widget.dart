import 'package:clients_digcoach/core/constants/colors.dart';
import 'package:clients_digcoach/repositories/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/functions.dart';

class AmenitiesWidget extends ConsumerStatefulWidget {
  const AmenitiesWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AmenitiesWidgetState();
}

class _AmenitiesWidgetState extends ConsumerState<AmenitiesWidget> {
  List<String> selectedReportList = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding:padding(context),
        child: MultiSelectChip(
          listItems: clubs[0].amenities,
          onSelectionChanged: (selectedList) =>
              setState(() => selectedReportList = selectedList),
          maxSelection: clubs[0].amenities.length,
          itemSelected: const [
            'freeParking',
            'ballsRenting',
            'changeRoom',
            'coffeeShop',
            'snackBar',
          ],
        ),
      ),
    );
  }
}


class MultiSelectChip extends StatefulWidget {
  const MultiSelectChip({
    super.key,
    required this.listItems,
    this.itemSelected,
    this.onSelectionChanged,
    this.onMaxSelected,
    this.maxSelection,
  });

  final List<String> listItems;
  final List<String>? itemSelected;
  final Function(List<String>)? onSelectionChanged;
  final Function(List<String>)? onMaxSelected;
  final int? maxSelection;

  @override
  State<MultiSelectChip> createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<String> itemSelected = [];

  @override
  void initState() {
    itemSelected = widget.itemSelected ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];

    for (var item in widget.listItems) {
      choices.add(Container(
        padding: const EdgeInsets.all(5.0),
        child: ChoiceChip(
          label: Text(item),
          selected: itemSelected.contains(item),
          selectedColor: kSecondaryColor,
          onSelected: (selected) {
            if (itemSelected.length == (widget.maxSelection ?? -1) &&
                !itemSelected.contains(item)) {
              widget.onMaxSelected?.call(itemSelected);
            } else {
              setState(() {
                itemSelected.contains(item)
                    ? itemSelected.remove(item)
                    : itemSelected.add(item);
                widget.onSelectionChanged?.call(itemSelected);
              });
            }
          },
        ),
      ));
    }

    return choices;
  }
}
