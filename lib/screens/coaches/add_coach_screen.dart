import 'dart:typed_data';
import 'package:clients_digcoach/models/coach.dart';
import 'package:clients_digcoach/providers/coach_provider.dart';
import 'package:clients_digcoach/providers/home_provider.dart';
import 'package:clients_digcoach/utils/utils.dart';
import 'package:clients_digcoach/utils/widget_utils.dart';
import 'package:clients_digcoach/widgets/address_widget.dart';
import 'package:clients_digcoach/widgets/clubs/courts_widget.dart';
import 'package:clients_digcoach/widgets/bordered_field_widget.dart';
import 'package:clients_digcoach/widgets/phone_number_widget.dart';
import 'package:clients_digcoach/widgets/photos_picker_widget.dart';
import 'package:clients_digcoach/widgets/text_form_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddCoachScreen extends ConsumerStatefulWidget {
  const AddCoachScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddCoachScreenState();
}

class _AddCoachScreenState extends ConsumerState<AddCoachScreen> {
  final List<Uint8List> images = [];
  int genderIndex = 0;
  int coachingLevel = 1;
  DateTime birthday = DateTime.now();
  String _selectedDate = '';

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final secSurNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final postalCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isFirstTime = true;

  List<String> editImages = [];

  _editCoach() {
    phoneController.text = ref.watch(coachProvider).currentCoach!.phone;
    nameController.text = ref.watch(coachProvider).currentCoach!.name;
    surnameController.text = ref.watch(coachProvider).currentCoach!.surname;
    secSurNameController.text = ref.watch(coachProvider).currentCoach!.secondSurName!;
    descriptionController.text = ref.watch(coachProvider).currentCoach!.description!;
    genderIndex = ref.watch(coachProvider).currentCoach!.isMale == true ? 0 : 1;
    editImages = ref.read(coachProvider).currentCoach!.photoUrl!;
    coachingLevel = ref.read(coachProvider).currentCoach!.coachingLevel;

    countryController.text = ref.watch(coachProvider).currentCoach!.country!;
    cityController.text = ref.watch(coachProvider).currentCoach!.city!;
    streetController.text = ref.watch(coachProvider).currentCoach!.street!;
    postalCodeController.text = ref.watch(coachProvider).currentCoach!.postalCode!;
    _selectedDate = ref.watch(coachProvider).currentCoach!.birthDate;
    _isFirstTime = false;
  }

  _resetCoach() {
    phoneController.text = '';
    nameController.text = '';
    secSurNameController.text = '';
    secSurNameController.text = '';
    genderIndex = 0;
    birthday = DateTime.now();
    _selectedDate = '';
    coachingLevel = 1;
    _isFirstTime = false;

  }


  /// As we come to the drawer ... it does run dispose method ...
  /// we have to deal with edit and add both on one page...
  /// When we come to edit data stored in forms ... go back and then again come on this page from add button side then we have to clear the previous form value
  /// for this purpose we listen to the end drawer changing ...

  _checkForm() {
    if(ref.watch(homeProvider).endDrawerStatus == true && ref.watch(coachProvider).isEdit == true) {
      _editCoach();
    } else {
      _resetCoach();
    }
  }



  @override
  Widget build(BuildContext context) {
    if(_isFirstTime)_checkForm(); _isFirstTime = false;
    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    final genders = ['Male', 'Female'];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: WidgetUtils.padding(context, maxPadding: 16),
                child: Form(
                  key: _formKey,
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
                                    controller: surnameController,
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
                      // WidgetUtils.requiredText('Surname'),
                      // const SizedBox(height: 10),
                      // TextFormFieldWidget(
                      //   autovalidateMode: AutovalidateMode.onUserInteraction,
                      //   hintText: 'Surname',
                      //   controller: surnameController,
                      //   isRequired: true,
                      // ),
                      const SizedBox(height: 30),
                      const Text('Description', style: style),
                      const SizedBox(height: 10),
                      TextFormFieldWidget(
                        hintText: 'Description',
                        controller: descriptionController,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 30),
                      WidgetUtils.requiredText('Phone'),
                      const SizedBox(height: 10),
                      PhoneNumberWidget(phoneController: phoneController),
                      const SizedBox(height: 30),
                      const Text('Gender', style: style),
                      const SizedBox(height: 10),
                      ChoiceWidget(
                        titles: genders,
                        currentIndex: genderIndex,
                        onChangedIndex: (genderIndex) {
                          genderIndex = genderIndex;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text('Coaching Level', style: style),
                      const SizedBox(height: 10),
                      CoachingSliderWidget(
                        indexSlider: coachingLevel,
                        onChanged: (value) {
                          setState(() {
                            coachingLevel = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30),
                      const Text('Address', style: style),
                      const SizedBox(height: 10),
                      AddressWidget(
                        cityController: cityController,
                        countryController: countryController,
                        postalCodeController: postalCodeController,
                        streetController: streetController,
                      ),
                      const SizedBox(height: 30),
                      const Text('Image', style: style),
                      const SizedBox(height: 10),
                      PhotosPickerWidget(images: images, maxPickedImages: 1, editImages: editImages),
                      const SizedBox(height: 30),
                      const Text('Birthday', style: style),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: BirthdayPickerWidget(
                          dateTime: birthday,
                          onChanged: (birthday) {
                            setState(() {
                              this.birthday = birthday;
                              var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
                              _selectedDate = outputFormat.format(this.birthday);
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            child: const Text('Submit'),
                            onPressed: () async {
                              if(_formKey.currentState!.validate()) {
                                Coach coach = Coach(
                                    id: ref.watch(coachProvider).isEdit ? ref.read(coachProvider).currentCoach!.id : '',
                                    // clubsId: [],
                                    name: nameController.text,
                                    surname: surnameController.text,
                                    secondSurName: secSurNameController.text,
                                    phone: phoneController.text,
                                    active: false,
                                    coachingLevel: coachingLevel,
                                    description: descriptionController.text,
                                  isMale: genders[genderIndex] == 'Male' ? true : false,
                                  country: countryController.text,
                                  city: cityController.text,
                                    photoUrlInBytes: images,
                                  photoUrl: ref.watch(coachProvider).isEdit ? ref.watch(coachProvider).currentCoach!.photoUrl : [],
                                  birthDate: _selectedDate,
                                  street: streetController.text,
                                  postalCode: postalCodeController.text
                                );
                                if(ref.watch(coachProvider).isEdit) {
                                  ref.watch(coachProvider).updateCoach(coach, context);
                                } else {
                                  ref.watch(coachProvider).addCoach(coach, context);
                                }

                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CoachingSliderWidget extends StatefulWidget {
  final int indexSlider;
  final ValueChanged<int> onChanged;

  const CoachingSliderWidget(
      {super.key, required this.indexSlider, required this.onChanged});

  @override
  State<CoachingSliderWidget> createState() => _CoachingSliderWidgetState();
}

class _CoachingSliderWidgetState extends State<CoachingSliderWidget> {
  @override
  Widget build(BuildContext context) {
    final labels = ['1', '10'];
    const double min = 1;
    const double max = 10;
    final int divisions = max.toInt();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          value: widget.indexSlider.toDouble(),
          min: min,
          max: max,
          divisions: divisions,
          label: '${widget.indexSlider}',
          onChanged: (value) => widget.onChanged(value.toInt()),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              labels.length,
              (index) {
                final label = labels[index];

                const selectedColor = Colors.black;
                final unselectedColor = Colors.black.withOpacity(0.3);
                final isSelected = index <= widget.indexSlider;
                final color = isSelected ? selectedColor : unselectedColor;

                return buildLabel(label: label, color: color, width: 30);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLabel({
    required String label,
    required double width,
    required Color color,
  }) =>
      SizedBox(
        width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ).copyWith(color: color),
        ),
      );
}

class BirthdayPickerWidget extends StatefulWidget {
  final DateTime dateTime;
  final ValueChanged<DateTime> onChanged;

  const BirthdayPickerWidget({
    super.key,
    required this.dateTime,
    required this.onChanged,
  });

  @override
  State<BirthdayPickerWidget> createState() => _BirthdayPickerWidgetState();
}

class _BirthdayPickerWidgetState extends State<BirthdayPickerWidget> {
  bool value = false;
  late DateTime birthday;

  @override
  void initState() {
    super.initState();

    birthday = widget.dateTime;
  }

  @override
  Widget build(BuildContext context) {
    return BorderedFieldWidget(
      text: Utils.toDateYYMMDD(widget.dateTime),
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Pick Birthday',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: StatefulBuilder(
                builder: (context, setState) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height:
                          MediaQuery.of(context).copyWith().size.height * 0.25,
                      width: 400,
                      child: CupertinoDatePicker(
                        dateOrder: DatePickerDateOrder.ymd,
                        minimumYear: 1900,
                        maximumYear: DateTime.now().year,
                        initialDateTime: birthday,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (birthday) {
                          setState(() {
                            this.birthday = birthday;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    widget.onChanged(birthday);
                    Navigator.pop(context);
                  },
                  child: const Text('SELECT'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
