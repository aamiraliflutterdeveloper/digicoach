import 'package:clients_digcoach/data/clubs.dart';
import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/models/club/club.dart';
import 'package:clients_digcoach/models/coach.dart';
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class CoachDataGridWidget extends ConsumerStatefulWidget {
  const CoachDataGridWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CoachDataGridWidgetState();
}

class _CoachDataGridWidgetState extends ConsumerState<CoachDataGridWidget> {
  final titles = const [
    'Photo',
    'Name',
    'Surname',
    'Phone',
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
            titles.length,
            (index) {
              final title = titles[index];
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
          (coach) => DataGridRow(
            cells: [
              DataGridCell(
                columnName: 'Photo',
                value: coach.image,
              ),
              DataGridCell<String>(
                columnName: 'Name',
                value: coach.name,
              ),
              DataGridCell<String>(
                columnName: 'Surname',
                value: coach.surname,
              ),
              DataGridCell(
                columnName: 'Phone',
                value: coach.phone,
              ),
              DataGridCell(
                columnName: 'Clubs',
                value: clubs
                    .where((club) => coach.clubsId.contains(club.id))
                    .toList(),
              ),
              DataGridCell(
                columnName: 'Actions',
                value: {'0': coach, '1': ref},
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
          (cell) {
            return Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: buildCells(cell),
            );
          },
        ).toList(),
      );

  void _removeCoach(DataGridCell<dynamic> dataGridCell) {
    final id = (dataGridCell.value['0'] as Coach).id;
    final ref = (dataGridCell.value['1'] as WidgetRef);

    ref.read(coachProvider).removeCoachById(id);
  }

  Widget buildCells(DataGridCell<dynamic> cell) {
    if (cell.columnName == 'Actions') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: AppColors.primaryColor),
          ),
          IconButton(
            onPressed: () => _removeCoach(cell),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      );
    } else if (cell.columnName == 'Photo') {
      final url = cell.value as String;

      return Image.network(url, fit: BoxFit.cover, width: 64);
    } else if (cell.columnName == 'Clubs') {
      final clubs = cell.value as List<Club>;
      final clubNames = clubs.map((club) => club.generalInfo.name).toList();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: clubNames
            .map((clubName) => Text(
                  clubName,
                  style: const TextStyle(color: AppColors.primaryColor),
                ))
            .toList(),
      );
    } else {
      return Text(
        cell.value.toString(),
        style: const TextStyle(color: AppColors.primaryColor),
      );
    }
  }
}
