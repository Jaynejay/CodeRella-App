import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Screens
import 'screens/user_list_screen.dart';

// Your pages
import 'pages/landing_page.dart';
import 'pages/login_page.dart';
import 'pages/homepage.dart';
import 'pages/add_submission_page.dart';
import 'pages/upload_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paper Sync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF1B3B6F),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B3B6F),
          primary: const Color(0xFF1B3B6F),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LandingPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        // from user_list_screen.dart
        '/users': (context) => UserListScreen(), 
      },
    );
  }
}
