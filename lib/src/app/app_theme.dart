import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tema do aplicativo, principalmente a paleta de cores utilizada.
class AppTheme {
  static const primaryColor = Color(0xff004fe0);
  static const secondaryColor = Color(0xff404042);
  static const tertiaryColor = Color(0xffd9d9d9);

  /// Definiçõa do tema do aplicativo, retornando ThemeData.
  static ThemeData get theme {
    return ThemeData(
      // Fonte "Press Start 2P", do Google Fonts.
      textTheme: GoogleFonts.pressStart2pTextTheme().apply(
        bodyColor: secondaryColor,
        displayColor: secondaryColor,
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
      ),
    );
  }
}