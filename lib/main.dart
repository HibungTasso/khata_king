import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khata_king/navigation.dart';

//------THEME------
final lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.purpleAccent);
final darkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 31, 7, 79),
);

//Light Theme
final lightTheme = ThemeData().copyWith(
  colorScheme: lightColorScheme,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.onPrimaryContainer,
    foregroundColor: Colors.white,  // <-- sets icon & text color
  ),
);


//Dark THEME
final darkTheme = ThemeData().copyWith(colorScheme: darkColorScheme,
  textTheme: TextTheme().copyWith(
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
  ),
);

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: lightTheme, 
    darkTheme: darkTheme,
    home: Navigation(),
    
    );
  }
}
