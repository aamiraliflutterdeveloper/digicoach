import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberWidget extends StatelessWidget {
  final TextEditingController phoneController;
  const PhoneNumberWidget({Key? key, required this.phoneController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      onInputChanged: (number) => print("sjdsdl"),
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
