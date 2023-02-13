import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../core/constants/colors.dart';
import '../../models/club.dart';

class ClubDataGridWidget extends ConsumerStatefulWidget {
  const ClubDataGridWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ClubDataGridWidgetState();
}

class _ClubDataGridWidgetState extends ConsumerState<ClubDataGridWidget> {
  final _title = const [
    'Photo',
    'Name',
    'City',
    'Phone',
    'Number Courts',
    'Actions',
  ];

  @override
  Widget build(BuildContext context) => ref.watch(clubProvider).isLoading
      ? const Center(child: CircularProgressIndicator())
      : SfDataGrid(
          defaultColumnWidth: 200,
          source: ClubsDataSource(context: context, ref: ref),
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

class ClubsDataSource extends DataGridSource {
  ClubsDataSource({required BuildContext context, required WidgetRef ref}) {
    final clubs = ref.watch(clubProvider).clubs;
    dataGridRows = clubs
        .map<DataGridRow>(
          (dataGridRow) => DataGridRow(
            cells: [
              DataGridCell<List<String>>(
                columnName: 'Photo',
                value: dataGridRow.generalInfo.images,
              ),
              DataGridCell<String>(
                columnName: 'Name',
                value: dataGridRow.generalInfo.name,
              ),
              DataGridCell<String>(
                columnName: 'City',
                value: dataGridRow.generalInfo.city,
              ),
              DataGridCell<String>(
                columnName: 'Phone',
                value: dataGridRow.generalInfo.phone,
              ),
              DataGridCell<int>(
                columnName: 'Number Courts',
                value: dataGridRow.courts
                    .where((element) => element.clubId == dataGridRow.id)
                    .length,
              ),
              DataGridCell(
                columnName: 'Actions',
                value: {'0': dataGridRow, '1': clubs, '2': ref, '3': context},
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
                            final context =
                                (dataGridCell.value['3'] as BuildContext);
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
                  : dataGridCell.columnName == 'Photo'
                      ? Column(
                          children: (dataGridCell.value as List<String>)
                              .map((e) => Image.network(
                                    e,
                                    fit: BoxFit.fill,
                                    height: 45,
                                    width: 100,
                                  ))
                              .toList())
                      : Text(
                          dataGridCell.value.toString(),
                          style: const TextStyle(color: kPrimaryColor),
                        ),
            );
          },
        ).toList(),
      );

  void _removeClub(DataGridCell<dynamic> dataGridCell) {
    final id = (dataGridCell.value['0'] as Club).id;
    final clubs = (dataGridCell.value['1'] as List<Club>);
    final ref = (dataGridCell.value['2'] as WidgetRef);
    if (id == clubs.first.id) return;
    ref.read(clubProvider).removeClubById(id);
  }
}
