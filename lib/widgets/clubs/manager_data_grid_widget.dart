import 'package:cached_network_image/cached_network_image.dart';
import 'package:clients_digcoach/models/club/manager.dart';
import 'package:clients_digcoach/models/end_drawer_popup.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/home_provider.dart';
import 'package:clients_digcoach/widgets/empty_record_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../data/colors.dart';

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
    'Actions'
  ];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) => ref.watch(clubProvider).isLoading
      ? const Center(child: CircularProgressIndicator())
      : ref.watch(clubProvider).isLoading == false && ref.watch(clubProvider).managers.isEmpty ? const EmptyRecordWidget(title: "Empty Manager") : SfDataGrid(
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
  final BuildContext context;
  final WidgetRef ref;
  ManagerDataSource({
    required this.context,
    required this.ref,
  }) {
    final managers = ref.watch(clubProvider).managers;
    const String noProfileImage = 'assets/images/placeholder_img.png';

    dataGridRows = managers
        .map<DataGridRow>(
          (manager) {
            String photo = manager.photoUrl == null || manager.photoUrl!.isEmpty ? noProfileImage : manager.photoUrl![0];
            return DataGridRow(
              cells: [
                DataGridCell<String>(
                  columnName: 'Photo',
                  value: photo,
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
                DataGridCell<bool>(
                  columnName: 'Read Permissions',
                  value: manager.permission[1].read,
                ),
                DataGridCell<bool>(
                  columnName: 'Edit Permissions',
                  value: manager.permission[1].readWrite,
                ),
                DataGridCell(
                  columnName: 'Actions',
                  value: {'0': manager, '1': ref},
                ),
              ],
            );
          },
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
    final manager = (cell.value['0'] as Manager);
    final ref = (cell.value['1'] as WidgetRef);

    ref.read(clubProvider).removeManagerById(manager, context);
  }

  Widget buildCells(DataGridCell<dynamic> cell) {
    if (cell.columnName == 'Actions') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              final ref = cell.value['1'] as WidgetRef;
              final manager = cell.value['0'] as Manager;
              ref.read(homeProvider).endDrawerPopup =
                  EndDrawerPopup.addManager;
              Scaffold.of(context).openEndDrawer();
              ref.read(clubProvider).setManagerEditData = manager;
            },
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
      if(url == 'assets/images/placeholder_img.png') {
        return Image.asset(url, fit: BoxFit.cover, width: 64);
      } else {
        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: 64,
          placeholder: (context, url) => const Center(child: SizedBox(height: 30, width: 30, child: CircularProgressIndicator())),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        );
      }

    } else if (cell.columnName == 'Manage All Clubs') {
      final manageAllClubs = cell.value as bool;

      return Checkbox(value: manageAllClubs, onChanged: (_) {});
    } else if (cell.columnName == 'Read Permissions') {

      final readPermissions = cell.value as bool;
      return Checkbox(value: readPermissions, onChanged: (_) {});
    } else if (cell.columnName == 'Edit Permissions') {

      final readWritePermissions = cell.value as bool;
      return Checkbox(value: readWritePermissions, onChanged: (_) {});
    }  else {
      return Text(
        cell.value.toString(),
        style: const TextStyle(color: AppColors.primaryColor),
      );
    }
  }
}





