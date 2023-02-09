import 'dart:typed_data';

import 'package:clients_digcoach/core/constants/colors.dart';
import 'package:clients_digcoach/widgets/text_form_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../core/constants/functions.dart';

class GeneralInfoWidget extends StatefulWidget {
  const GeneralInfoWidget({super.key});

  @override
  State<GeneralInfoWidget> createState() => _GeneralInfoWidgetState();
}

class _GeneralInfoWidgetState extends State<GeneralInfoWidget> {
  final images = [];
  Uint8List? image;

  final scrollController = ScrollController();

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
          const Text('Name', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Name',
            controller: nameController,
            isRequired: true,
          ),

          const SizedBox(height: 30),

          ///
          const Text('Phone', style: style),
          const SizedBox(height: 10),
          InternationalPhoneNumberInput(
            onInputChanged: (PhoneNumber number) {
              print(number.phoneNumber);
            },
            onInputValidated: (bool value) {
              print(value);
            },
            selectorConfig: const SelectorConfig(
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            ),
            ignoreBlank: false,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            selectorTextStyle: const TextStyle(color: Colors.black),
            initialValue: PhoneNumber(isoCode: 'US'),
            textFieldController: phoneController,
            formatInput: true,
            keyboardType: const TextInputType.numberWithOptions(
                signed: true, decimal: true),
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
            child: Row(
              children: [
                InkWell(
                  onTap: () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(type: FileType.image);

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
                  },
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
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemCount: images.length,
                    separatorBuilder: (context, _) => const SizedBox(width: 10),
                    itemBuilder: (context, index) => Image.memory(
                      images[index],
                      // 'https://images.unsplash.com/photo-1567220720374-a67f33b2a6b9?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8dGVubmlzJTIwY291cnR8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
                      fit: BoxFit.cover,
                      width: 200,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text('Website Url', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Url',
            controller: websiteUrlController,
          ),
          const SizedBox(height: 30),
          const Text('Email', style: style),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Email',
            controller: emailController,
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
            hintText: 'Facebook Url',
            controller: facebookUrlController,
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Instagram Url',
            controller: instagramUrlController,
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'Twitter Url',
            controller: twitterUrlController,
          ),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            hintText: 'TikTok Url',
            controller: tiktokUrlController,
          ),

        ],
      ),
    );
  }
}
