
import 'package:flutter/material.dart';

class AppTheme {
AppTheme._();

 /*static ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Color(0xFF003366), // Azul escuro para o saldo
  scaffoldBackgroundColor: Colors.white,
  textTheme: TextTheme(
    headlineMedium: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    titleMedium: TextStyle(color: Colors.grey[600]),
    bodyMedium: TextStyle(color: Colors.black87),
    ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF003366), // Botões em azul
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFF003366),
    unselectedItemColor: Colors.grey[500],
    showUnselectedLabels: false,
    backgroundColor: Colors.white,
  ),
  cardTheme: CardTheme(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 2,
    color: Colors.white,
  ),
);*/

static ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFF2F4F7),
    primary: Color(0xFF3068EF),
  ),
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16),
    bodySmall: TextStyle(fontSize: 14),
  ),
);


static ThemeData darkTheme = ThemeData(
brightness: Brightness.dark,
colorScheme: const ColorScheme.dark(
background: Color(0xFF0D1B2A),
primary: Color(0xFF3A86FF),
),
textTheme: const TextTheme(
headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
bodyMedium: TextStyle(fontSize: 16),
bodySmall: TextStyle(fontSize: 14),
),
);

}