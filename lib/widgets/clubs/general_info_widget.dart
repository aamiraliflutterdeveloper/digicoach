import 'dart:typed_data';

import 'package:clients_digcoach/data/clubs.dart';
import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/models/club/club.dart';
import 'package:clients_digcoach/models/club/general_info.dart';
import 'package:clients_digcoach/utils/utils.dart';
import 'package:clients_digcoach/utils/widget_utils.dart';
import 'package:clients_digcoach/widgets/address_widget.dart';
import 'package:clients_digcoach/widgets/phone_number_widget.dart';
import 'package:clients_digcoach/widgets/photos_picker_widget.dart';
import 'package:clients_digcoach/widgets/text_form_field_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../providers/add_club_provider.dart';
import '../../providers/club_provider.dart';

class GeneralInfoWidget extends ConsumerStatefulWidget {
  const GeneralInfoWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GeneralInfoWidgetState();
}

class _GeneralInfoWidgetState extends ConsumerState<GeneralInfoWidget> {
  final List<Uint8List> images = [];
  Club? club;

  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final postalCodeController = TextEditingController();
  final websiteUrlController = TextEditingController();
  final facebookUrlController = TextEditingController();
  final instagramUrlController = TextEditingController();
  final twitterUrlController = TextEditingController();
  final tiktokUrlController = TextEditingController();
  final emailController = TextEditingController();
  final surnameController = TextEditingController();
  final ceoNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          WidgetUtils.requiredText('Phone'),
          const SizedBox(height: 10),
          PhoneNumberWidget(phoneController: phoneController),
          const SizedBox(height: 30),
          const Text('Description', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Description',
            controller: descriptionController,
            maxLines: 5,
          ),
          const SizedBox(height: 30),
          const Text('Location', style: style),
          const SizedBox(height: 10),
          AddressWidget(
            cityController: cityController,
            countryController: countryController,
            postalCodeController: postalCodeController,
            streetController: streetController,
          ),
          const SizedBox(height: 30),
          const Text('Images', style: style),
          const SizedBox(height: 10),
          PhotosPickerWidget(images: images),
          const SizedBox(height: 30),
          const Text('Website Url', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Url',
            controller: websiteUrlController,
            validator: (url) => Utils.isUrlValid(url!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 30),
          const Text('Email', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Email',
            controller: emailController,
            validator: (value) =>
                EmailValidator.validate(value!) ? null : 'Invalid email',
          ),
          const SizedBox(height: 30),
          const Text('Ceo Name', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Ceo Name',
            controller: ceoNameController,
          ),
          const SizedBox(height: 30),
          const Text('Surname', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Surname',
            controller: surnameController,
          ),
          const SizedBox(height: 30),
          const Text('Social', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Facebook Url',
            controller: facebookUrlController,
            validator: (url) => Utils.isUrlValid(url!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Instagram Url',
            controller: instagramUrlController,
            validator: (url) => Utils.isUrlValid(url!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Twitter Url',
            controller: twitterUrlController,
            validator: (url) => Utils.isUrlValid(url!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'TikTok Url',
            controller: tiktokUrlController,
            validator: (url) => Utils.isUrlValid(url!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text('Next'),
                onPressed: () async {
                  // final club = Club(
                  //   id: '${clubs.length + 1}',
                  //   generalInfo: GeneralInfo(
                  //     id: '${clubs.length + 1}',
                  //     name: nameController.text,
                  //     phone: phoneController.text,
                  //     email: emailController.text,
                  //     city: cityController.text,
                  //     ceoName: ceoNameController.text,
                  //     country: countryController.text,
                  //     description: descriptionController.text,
                  //     facebook: facebookUrlController.text,
                  //     images: images,
                  //     instagram: instagramUrlController.text,
                  //     postalCode: postalCodeController.text,
                  //     street: streetController.text,
                  //     surname: surnameController.text,
                  //     tiktok: tiktokUrlController.text,
                  //     twitter: twitterUrlController.text,
                  //     url: websiteUrlController.text,
                  //   ),
                  //   amenities: [],
                  //   coaches: [],
                  //   courts: [],
                  //   openingHours: [],
                  //   holidays: [],
                  //   reservations: [],
                  // );
                  //
                  // await ref.read(clubProvider).addClub(club);
                  ref.read(addClubProvider).tabIndex = 1;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
