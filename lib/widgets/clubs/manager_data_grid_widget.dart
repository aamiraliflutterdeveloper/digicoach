import 'package:clients_digcoach/models/club/manager.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../data/colors.dart';
import '../../models/club/club.dart';

class ManagerDataGridWidget extends ConsumerStatefulWidget {
  const ManagerDataGridWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManagerDataGridWidgetState();
}

class _ManagerDataGridWidgetState extends ConsumerState<ManagerDataGridWidget> {
  final _titles = const [
    'Photo',
    'Name',
    'Email',
    'Manage All Clubs',
    'Read Permissions',
    'Edit Permissions',
    'Actions',
  ];

  @override
  Widget build(BuildContext context) => ref.watch(clubProvider).isLoading
      ? const Center(child: CircularProgressIndicator())
      : SfDataGrid(
          defaultColumnWidth: 200,
          source: ManagerDataSource(context: context, ref: ref),
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

class ManagerDataSource extends DataGridSource {
  ManagerDataSource({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final managers = ref.watch(clubProvider).managers;

    dataGridRows = managers
        .map<DataGridRow>(
          (manager) => DataGridRow(
            cells: [
              DataGridCell<String>(
                columnName: 'Photo',
                value: manager.photoUrl,
              ),
              DataGridCell<String>(
                columnName: 'Name',
                value: manager.name,
              ),
              DataGridCell<String>(
                columnName: 'Email',
                value: manager.email,
              ),
              DataGridCell<bool>(
                columnName: 'Manage All Clubs',
                value: manager.manageAllClubs,
              ),
              DataGridCell<List<bool>>(
                columnName: 'Read Permissions',
                value: manager.readPermissions,
              ),
              DataGridCell<List<bool>>(
                columnName: 'Edit Permissions',
                value: manager.readWritePermissions,
              ),
              DataGridCell(
                columnName: 'Actions',
                value: {'0': manager, '1': ref},
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

  void _removeClub(DataGridCell<dynamic> cell) {
    final id = (cell.value['0'] as Manager).id;
    final ref = (cell.value['1'] as WidgetRef);

    ref.read(clubProvider).removeManagerById(id);
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
            onPressed: () => _removeClub(cell),
            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      );
    } else if (cell.columnName == 'Photo') {
      final url = cell.value as String;

      return Image.network(url, fit: BoxFit.cover, width: 64);
    } else if (cell.columnName == 'Manage All Clubs') {
      final manageAllClubs = cell.value as bool;

      return Checkbox(value: manageAllClubs, onChanged: (_) {});
    } else if (cell.columnName == 'Read Permissions') {
      final readPermissions = cell.value as List<bool>;
      final value = readPermissions.every((permission) => permission);

      return Checkbox(value: value, onChanged: (_) {});
    } else if (cell.columnName == 'Edit Permissions') {
      final readWritePermissions = cell.value as List<bool>;
      final value = readWritePermissions.every((permission) => permission);

      return Checkbox(value: value, onChanged: (_) {});
    } else {
      return Text(
        cell.value.toString(),
        style: const TextStyle(color: AppColors.primaryColor),
      );
    }
  }
}
