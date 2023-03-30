import 'package:clients_digcoach/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class AddressWidget extends StatelessWidget {
  final TextEditingController countryController;
  final TextEditingController cityController;
  final TextEditingController streetController;
  final TextEditingController postalCodeController;

  const AddressWidget({
    super.key,
    required this.countryController,
    required this.cityController,
    required this.streetController,
    required this.postalCodeController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }
}
