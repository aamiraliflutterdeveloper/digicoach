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
        apiKey: "AIzaSyDqNP8XwlaXIKKrfwUaMMsS0AT17ZL1Bv4",
        authDomain: "digicoach-49ee0.firebaseapp.com",
        projectId: "digicoach-49ee0",
        storageBucket: "digicoach-49ee0.appspot.com",
        messagingSenderId: "631059407718",
        appId: "1:631059407718:web:9dcd8e5a1ea9bb64135ea7",
        measurementId: "G-D7WZC6EXF6"
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
