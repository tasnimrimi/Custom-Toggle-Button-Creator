import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const SwitchBuilderApp());
}

class SwitchBuilderApp extends StatelessWidget {
  const SwitchBuilderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Switch Creation Tool',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F14),
        fontFamily: 'Inter',
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7C6FF7),
          surface: Color(0xFF1A1A24),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
