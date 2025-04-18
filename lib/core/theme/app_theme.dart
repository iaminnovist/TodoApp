import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE17055),
        ),
        useMaterial3: true,
      );

  static ThemeData get dark => ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE17055),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      );
} 