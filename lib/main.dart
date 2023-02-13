import 'package:clients_digcoach/core/constants/functions.dart';
import 'package:clients_digcoach/screens/home_page.dart';
import 'package:clients_digcoach/widgets/text_form_field_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: kDebugMode ? HomePage() : LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: padding(context),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormFieldWidget(
                  hintText: 'Password',
                  validator: (value) =>
                      value == null || value.isEmpty || value != 'xEK52N3!X85u'
                          ? 'Wrong Password'
                          : null,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(fixedSize: const Size(200, 50)),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
