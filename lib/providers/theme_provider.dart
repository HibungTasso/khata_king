import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final themeProvider = StateProvider<ThemeMode>((ref){
  return ThemeMode.light; //Default

  //Later change the ThemeMode to System Theme Mode
});