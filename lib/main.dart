import 'package:flutter/material.dart';

//------THEME------
final lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.purpleAccent);
final darkColorScheme = ColorScheme.fromSeed(brightness: Brightness.dark,seedColor: const Color.fromARGB(255, 31, 7, 79));

//Light Theme
final lightTheme = ThemeData().copyWith(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: lightColorScheme.onPrimaryContainer,
    foregroundColor: Colors.white,
  ),
  textTheme: TextTheme().copyWith(
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
  )
);

//Dark THEME
final darkTheme = ThemeData().copyWith(
  colorScheme: darkColorScheme,
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      );
  }
}
