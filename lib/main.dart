import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const NeuroQuestApp());
}

class NeuroQuestApp extends StatelessWidget {
  const NeuroQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeuroQuest',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF6BAAF7),
        fontFamily: 'sans-serif',
      ),
      home: const WelcomeScreen(),
    );
  }
}
