import 'dart:typed_data';

import 'package:clients_digcoach/core/constants/colors.dart';
import 'package:clients_digcoach/models/club.dart';
import 'package:clients_digcoach/models/general_info.dart';
import 'package:clients_digcoach/repositories/club_repository.dart';
import 'package:clients_digcoach/widgets/button_widget.dart';
import 'package:clients_digcoach/widgets/text_form_field_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../core/constants/functions.dart';
import '../../providers/club_provider.dart';

class GeneralInfoWidget extends ConsumerStatefulWidget {
  const GeneralInfoWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GeneralInfoWidgetState();
}

class _GeneralInfoWidgetState extends ConsumerState<GeneralInfoWidget> {
  final images = [];
  Uint8List? image;
  Club? club;

  ///
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  ///
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
  final surNameController = TextEditingController();
  final ceoNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
    return Form(
      key: formKey,
      child: ListView(
        padding: padding(context),
        children: [
          requiredText('Name'),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Name ',
            controller: nameController,
            isRequired: true,
          ),

          const SizedBox(height: 30),

          ///
          requiredText('Phone'),
          const SizedBox(height: 10),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) => print(number.phoneNumber),
            onInputValidated: (bool value) => print(value),
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: PhoneNumber(isoCode: 'US'),
            textFieldController: phoneController,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            inputBorder: const OutlineInputBorder(),
          ),

          const SizedBox(height: 30),

          ///
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
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Country',
                  controller: countryController,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'City',
                  controller: cityController,
                  isRequired: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Street',
                  controller: streetController,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormFieldWidget(
                  hintText: 'Postal code',
                  controller: postalCodeController,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          ///
          const Text('Images', style: style),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: _pickImage(),
          ),
          const SizedBox(height: 30),
          const Text('Website Url', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Url',
            controller: websiteUrlController,
            validator: (value) => urlValidation(value!) ? null : 'Invalid Url',
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
          const Text('Sur Name', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Sur Name',
            controller: surNameController,
          ),
          const SizedBox(height: 30),
          const Text('Social', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Facebook Url',
            controller: facebookUrlController,
            validator: (value) => urlValidation(value!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Instagram Url',
            controller: instagramUrlController,
            validator: (value) => urlValidation(value!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'Twitter Url',
            controller: twitterUrlController,
            validator: (value) => urlValidation(value!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            hintText: 'TikTok Url',
            controller: tiktokUrlController,
            validator: (value) => urlValidation(value!) ? null : 'Invalid Url',
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonWidget(
                title: 'Next',
                fixedSize: const Size(100, 50),
                onPressed: () async{

                await  ref.read(clubProvider).addClub(
                        Club(
                          id: '${clubs.length + 1}',
                          generalInfo: GeneralInfo(
                            id: '${clubs.length + 1}',
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                            city: cityController.text,
                            active: true,
                            ceoName: ceoNameController.text,
                            country: countryController.text,
                            description: descriptionController.text,
                            facebook: facebookUrlController.text,
                            images: images as List<String>,
                            instagram: instagramUrlController.text,
                            postalCode: postalCodeController.text,
                            street: streetController.text,
                            surName: surNameController.text,
                            tiktok: tiktokUrlController.text,
                            twitter: twitterUrlController.text,
                            url: websiteUrlController.text,
                          ),
                          amenities: [],
                          coaches: [],
                          courts: [],
                          days: [],
                          holidays: [],
                          reservations: [],
                        ),
                      );
                  ref.watch(clubProvider).addClubCurrentTap = 1;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row _pickImage() => Row(
        children: [
          InkWell(
            onTap: _onTap,
            child: SizedBox(
              height: 100,
              width: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(
                    Icons.add_a_photo,
                    color: kPrimaryColor,
                    size: 70,
                  ),
                  Text('Add Image', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (context, _) => const SizedBox(width: 10),
              itemBuilder: (context, index) => Image.memory(
                images[index],
                fit: BoxFit.cover,
                width: 200,
                height: 100,
              ),
            ),
          ),
        ],
      );

  Future<void> _onTap() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      Uint8List? fileBytes = result.files.first.bytes;
      String fileName = result.files.first.name;
      setState(() {
        image = fileBytes;
        images.add(image);
      });

      // Upload file
      // await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes);
    }
  }
}
