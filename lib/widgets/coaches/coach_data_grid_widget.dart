import 'package:cached_network_image/cached_network_image.dart';
import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/models/coach.dart';
import 'package:clients_digcoach/models/end_drawer_popup.dart';
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:clients_digcoach/providers/home_provider.dart';
import 'package:clients_digcoach/widgets/empty_record_widget.dart';
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
      ? const Center(child: CircularProgressIndicator()) :
  ref.watch(coachProvider).isLoading == false && ref.watch(coachProvider).coaches.isEmpty
      ? const EmptyRecordWidget(title: "Empty Coach")
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
  final BuildContext context;
  final WidgetRef ref;
  CoachesDataSource({required this.context, required this.ref}) {
    final coaches = ref.watch(coachProvider).coaches;
    const String noProfileImage = 'assets/images/placeholder_img.png';

    dataGridRows = coaches
        .map<DataGridRow>(
          (coach) {
            String photo = coach.photoUrl == null || coach.photoUrl!.isEmpty ? noProfileImage : coach.photoUrl![0];
            return DataGridRow(
              cells: [
                DataGridCell(
                  columnName: 'Photo',
                  value: photo,
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
                const DataGridCell(
                    columnName: 'Clubs',
                    value: ['club1', 'club2']
                  // value: clubs
                  //     .where((club) => coach.clubsId.contains(club.id))
                  //     .toList(),
                ),
                DataGridCell(
                  columnName: 'Actions',
                  value: {'0': coach, '1': ref},
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
    final coach = (dataGridCell.value['0'] as Coach);
    final ref = (dataGridCell.value['1'] as WidgetRef);

    ref.read(coachProvider).removeCoachById(coach, context);
  }

  Widget buildCells(DataGridCell<dynamic> cell) {
    if (cell.columnName == 'Actions') {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              final ref = cell.value['1'] as WidgetRef;
              final coach = cell.value['0'] as Coach;
              ref.read(homeProvider).endDrawerPopup =
                  EndDrawerPopup.addCoach;
              Scaffold.of(context).openEndDrawer();
              ref.read(coachProvider).setCoachEditData = coach;
              // ref.watch(coachProvider).isEdit
            },
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
      // return Image.network(url, fit: BoxFit.cover, width: 64);
    } else if (cell.columnName == 'Clubs') {
      final clubs = cell.value as List<String>;
      // final clubNames = clubs.map((club) => club.generalInfo.name).toList();

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: clubs
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








