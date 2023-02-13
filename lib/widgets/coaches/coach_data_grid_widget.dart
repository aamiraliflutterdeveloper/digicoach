import 'package:clients_digcoach/models/coach.dart';
import 'package:clients_digcoach/models/coach.dart';
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../core/constants/colors.dart';


class CoachDataGridWidget extends ConsumerStatefulWidget {
  const CoachDataGridWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CoachDataGridWidgetState();
}

class _CoachDataGridWidgetState extends ConsumerState<CoachDataGridWidget> {

  final _title = const [
    'Photo',
    'Name',
    'Sur Name',
    'Clubs',
    'Actions',
  ];



  @override
  Widget build(BuildContext context) => ref.watch(coachProvider).isLoading
      ? const Center(child: CircularProgressIndicator())
      : SfDataGrid(
    defaultColumnWidth: 200,
    source: CoachesDataSource(context: context, ref: ref),
    columns: List.generate(
      _title.length,
          (index) {
        final title = _title[index];
        return GridColumn(
          columnName: title,
          label: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          ),
        );
      },
    ),
  );
}

class CoachesDataSource extends DataGridSource {
  CoachesDataSource({required BuildContext context, required WidgetRef ref}) {
    final coaches = ref.watch(coachProvider).coaches;
    dataGridRows = coaches
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
        cells: [
          DataGridCell(
            columnName: 'Photo',
            value: dataGridRow.image,
          ),
          DataGridCell<String>(
            columnName: 'Name',
            value: dataGridRow.name,
          ),
          DataGridCell<String>(
            columnName: 'Sur Name',
            value: dataGridRow.surName,
          ),
          DataGridCell(
            columnName: 'Clubs',
            value: dataGridRow.clubsId[0],
          ),
          DataGridCell(
            columnName: 'Actions',
            value: {'0': dataGridRow, '1': coaches, '2': ref, '3': context},
          ),
        ],
      ),
    )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) => DataGridRowAdapter(
    cells: row.getCells().map<Widget>(
          (dataGridCell) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: dataGridCell.columnName == 'Actions'
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  final context = (dataGridCell.value['3'] as BuildContext);
                },
                icon: const Icon(Icons.edit, color: kPrimaryColor),
              ),
              IconButton(
                onPressed: () => _removeClub(dataGridCell),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ],
          )
              : Text(
            dataGridCell.value.toString(),
            style: const TextStyle(color: kPrimaryColor),
          ),
        );
      },
    ).toList(),
  );

  void _removeClub(DataGridCell<dynamic> dataGridCell) {
    final id = (dataGridCell.value['0'] as Coach).id;
    final coaches = (dataGridCell.value['1'] as List<Coach>);
    final ref = (dataGridCell.value['2'] as WidgetRef);
  }
}
