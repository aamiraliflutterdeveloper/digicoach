import 'package:clients_digcoach/data/colors.dart';
import 'package:clients_digcoach/screens/home_page.dart';
import 'package:clients_digcoach/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// this is firebase initialization ...
// firebase settings ...
Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: const FirebaseOptions(
    ),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: kDebugMode ? const HomePage() : const LoginScreen(),
    );
  }
}
