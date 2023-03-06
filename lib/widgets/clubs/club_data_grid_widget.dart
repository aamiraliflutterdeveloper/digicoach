import 'package:clients_digcoach/providers/add_club_provider.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/colors.dart';
import '../../models/club/club.dart';

class ClubDataGridWidget extends ConsumerStatefulWidget {
  const ClubDataGridWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ClubDataGridWidgetState();
}

class _ClubDataGridWidgetState extends ConsumerState<ClubDataGridWidget> {
  final _titles = const [
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
            _titles.length,
            (index) {
              final title = _titles[index];

              return GridColumn(
                columnName: title,
                label: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        );
}

class ClubsDataSource extends DataGridSource {
  ClubsDataSource({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final clubs = ref.watch(clubProvider).clubs;

    dataGridRows = clubs
        .map<DataGridRow>(
          (club) => DataGridRow(
            cells: [
              const DataGridCell<List<String>>(
                columnName: 'Photo',
                value: [],
              ),
              DataGridCell<String>(
                columnName: 'Name',
                value: club.generalInfo.name,
              ),
              DataGridCell<String>(
                columnName: 'City',
                value: club.generalInfo.city,
              ),
              DataGridCell<String>(
                columnName: 'Phone',
                value: club.generalInfo.phone,
              ),
              DataGridCell<int>(
                columnName: 'Number Courts',
                value: club.courts
                    .where((element) => element.clubId == club.id)
                    .length,
              ),
              DataGridCell(
                columnName: 'Actions',
                value: {'0': club, '1': ref, '2': context},
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
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final cells = row.getCells();

    return DataGridRowAdapter(
      cells: cells
          .map<Widget>((cell) => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: buildCells(cell),
              ))
          .toList(),
    );
  }

  void _editClub(DataGridCell<dynamic> cell) {
    final club = cell.value['0'] as Club;
    final ref = (cell.value['1'] as WidgetRef);
    final context = (cell.value['2'] as BuildContext);

    ref.read(addClubProvider).club = club;

    Scaffold.of(context).openEndDrawer();
  }

  void _removeClub(DataGridCell<dynamic> cell) {
    final id = (cell.value['0'] as Club).id;
    final ref = (cell.value['1'] as WidgetRef);

    ref.read(clubProvider).removeClubById(id);
  }

  Widget buildCells(DataGridCell<dynamic> cell) {
    if (cell.columnName == 'Actions') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => _editClub(cell),
            icon: const Icon(Icons.edit, color: AppColors.primaryColor),
          ),
          IconButton(
            onPressed: () => _removeClub(cell),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      );
    } else if (cell.columnName == 'Photo') {
      final urls = cell.value as List<String>;
      return Column(
          children: urls
              .map((url) => Image.network(
                    url,
                    fit: BoxFit.fill,
                    height: 45,
                    width: 100,
                  ))
              .toList());
    } else {
      return Text(
        cell.value.toString(),
        style: const TextStyle(color: AppColors.primaryColor),
      );
    }
  }
}
