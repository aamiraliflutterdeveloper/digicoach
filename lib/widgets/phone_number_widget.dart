import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberWidget extends StatelessWidget {
  final TextEditingController phoneController;

  const PhoneNumberWidget({
    super.key,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (number) => print(number.phoneNumber),
      onInputValidated: (value) => print(value),
      selectorConfig: SelectorConfig(
        selectorType: PhoneInputSelectorType.DROPDOWN,
        countryComparator: (c1, c2) => c1.dialCode!.compareTo(c2.dialCode!),
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
    );
  }
}
