import 'dart:typed_data';
import 'package:clients_digcoach/models/club/club.dart';
import 'package:clients_digcoach/models/club/manager.dart';
import 'package:clients_digcoach/providers/club_provider.dart';
import 'package:clients_digcoach/providers/home_provider.dart';
import 'package:clients_digcoach/utils/widget_utils.dart';
import 'package:clients_digcoach/widgets/phone_number_widget.dart';
import 'package:clients_digcoach/widgets/photos_picker_widget.dart';
import 'package:clients_digcoach/widgets/text_form_field_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class ManagerInfoWidget extends ConsumerStatefulWidget {
  const ManagerInfoWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ManagerInfoWidgetState();
}

class _ManagerInfoWidgetState extends ConsumerState<ManagerInfoWidget> {
  final List<Uint8List> images = [];
  Club? club;

  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final surNameController = TextEditingController();
  final secSurNameController = TextEditingController();

  final _permissionTitle = const [
    'Name',
    'Read',
    'Write',
  ];

  bool manageClub = false;
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
  }

  List<String> editImages = [];
  _editManager() {
      ref.watch(clubProvider).setEditPermissions([]);
      phoneController.text = ref.watch(clubProvider).currentManager!.phone;
      nameController.text = ref.watch(clubProvider).currentManager!.name;
      emailController.text = ref.watch(clubProvider).currentManager!.email;
      surNameController.text = ref.watch(clubProvider).currentManager!.surname;
      secSurNameController.text = ref.watch(clubProvider).currentManager!.secondSurname!;
      ref.read(clubProvider).setEditPermissions(ref.watch(clubProvider).currentManager!.permission);
      ref.read(clubProvider).manageAllClub = ref.read(clubProvider).currentManager!.manageAllClubs;
      editImages = ref.read(clubProvider).currentManager!.photoUrl!;
      _isFirstTime = false;
  }

  _resetManagerForm() {
      phoneController.text = '';
      nameController.text = '';
      emailController.text = '';
      surNameController.text = '';
      secSurNameController.text = '';
      ref.read(clubProvider).manageAllClub = false;
      ref.read(clubProvider).setIsFromEdit(false);
      ref.read(clubProvider).getPermissions();
      _isFirstTime = false;
  }

  /// the text Editing controller values does not dispose in drawer ....
  /// that's why i am listening drawer changing from here and can dispose the controller values when drawer close...
  /// Is form of edit manager or add new manager ...
  /// I did not add parameters to the new page, except i am setting the edit manager data through thr provider ...

  _checkForm() {
    if(ref.watch(homeProvider).endDrawerStatus == true && ref.watch(clubProvider).isFromEdit == true) {
      _editManager();
    } else {
      _resetManagerForm();
    }
  }


  @override
  Widget build(BuildContext context) {
    if(_isFirstTime)_checkForm(); _isFirstTime = false;
    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WidgetUtils.requiredText('Name'),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Name',
            controller: nameController,
            isRequired: true,
          ),
          const SizedBox(height: 30),

          // surname and second surname ...
          SizedBox(
            height: 115,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      WidgetUtils.requiredText('Surname'),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: 'Surname',
                        controller: surNameController,
                        isRequired: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Second Surname", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        hintText: 'Second Surname',
                        controller: secSurNameController,
                        isRequired: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          WidgetUtils.requiredText('Phone'),
          const SizedBox(height: 10),
          PhoneNumberWidget(phoneController: phoneController),
          const SizedBox(height: 30),
          const Text('Images', style: style),
          const SizedBox(height: 10),
          PhotosPickerWidget(images: images, editImages: editImages),
          const SizedBox(height: 30),
          WidgetUtils.requiredText('Email'),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Email',
            controller: emailController,
            validator: (value) =>
            EmailValidator.validate(value!) ? null : 'Invalid email',
          ),
          const SizedBox(height: 30),
          const Text("Permissions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SizedBox(
            height: 560,
            child: SfDataGrid(
              gridLinesVisibility: GridLinesVisibility.none,
              headerGridLinesVisibility: GridLinesVisibility.none,
              defaultColumnWidth: 200,
              source: PermissionDataSource(context: context, ref: ref),
              columns: List.generate(
                _permissionTitle.length,
                    (index) {
                  final title = _permissionTitle[index];
                  return GridColumn(
                    columnName: title,
                    label: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          buildManageClub(),
          const SizedBox(height: 30),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () async {
                  if(formKey.currentState!.validate()) {
                    final Manager manager = Manager(
                      id: ref.watch(clubProvider).isFromEdit ? ref.read(clubProvider).currentManager!.id : '',
                      name: nameController.text,
                      surname: surNameController.text,
                      secondSurname: secSurNameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      manageAllClubs: ref.watch(clubProvider).getManageClub!,
                      photoUrlInBytes: images,
                      photoUrl: ref.watch(clubProvider).isFromEdit ? ref.watch(clubProvider).currentManager!.photoUrl : [],
                      permission: ref.watch(clubProvider).permissions!,
                    );
                    if(ref.watch(clubProvider).isFromEdit) {
                      ref.read(clubProvider).updateManager(manager, context);
                    } else {
                      ref.read(clubProvider).addManager(manager, context);
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget buildManageClub() =>
      Row(
        children: [
          Checkbox(
            value: ref.watch(clubProvider).getManageClub,
            onChanged: (manageAllClubs) {
              ref.read(clubProvider).manageAllClub = manageAllClubs!;
            },
          ),
          const Text('Manage All Clubs?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      );
}


class PermissionDataSource extends DataGridSource {
  PermissionDataSource({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    final permissions = ref.watch(clubProvider).permissions;
    dataGridRows = permissions!
        .map<DataGridRow>(
          (permission) => DataGridRow(
        cells: [
          DataGridCell<String>(
            columnName: 'Name',
            value: permission.name,
          ),
          DataGridCell(
            columnName: 'Read',
            value: {'0': permission.read, '1': permission.id, '2': ref, '3': context, '4': permission},
          ),
          DataGridCell(
            columnName: 'Write',
            value: {'0': permission.readWrite, '1': permission.id, '2': ref, '3': context, '4': permission},
          ),
        ],
      ),
    ).toList();
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
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: buildCells(cell),
      ))
          .toList(),
    );
  }

  Widget buildCells(DataGridCell<dynamic> cell) {
    if (cell.columnName == 'Read') {
      final value = cell.value['0'] as bool;
      final id = cell.value['1'] as int;
      final ref = (cell.value['2'] as WidgetRef);
      return Checkbox(value: value, onChanged: (val) {
       ref.read(clubProvider).updateRead(id, val);
      });
    }
     else  if (cell.columnName == 'Write') {
      final value = cell.value['0'] as bool;
      final id = cell.value['1'] as int;
      final ref = (cell.value['2'] as WidgetRef);
      return Checkbox(value: value, onChanged: (val) {
        ref.read(clubProvider).updateReadWrite(id, val);
      });
    } else {
      return Text(
        cell.value.toString(),
        style: const TextStyle(color: Colors.black),
      );
    }
  }

}




