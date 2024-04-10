import 'package:ciscord/screens/default_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 42, 6, 106),
          background: Colors.blueGrey[900],
          onPrimaryContainer: const Color.fromARGB(255, 42, 6, 106),
        ),
        textTheme: GoogleFonts.tiltNeonTextTheme(),
      ),
      home: const DefaultScreen(),
    );
  }
}
