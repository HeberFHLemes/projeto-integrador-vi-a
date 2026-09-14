import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tema do aplicativo, principalmente a paleta de cores utilizada.
class AppTheme {
  static const primaryColor = Color(0xff004fe0);
  static const secondaryColor = Color(0xff404042);
  static const tertiaryColor = Color(0xffd9d9d9);

  /// Definição do tema do aplicativo, retornando ThemeData.
  static ThemeData get theme {

    // Fonte "Press Start 2P", do Google Fonts.
    final textTheme = GoogleFonts.pressStart2pTextTheme().apply(
      bodyColor: secondaryColor,
      displayColor: secondaryColor,
    );

    // paleta de cores do app
    final colorScheme = ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: tertiaryColor,
    );

    // estilo de texto (principalmente tamanho da fonte) padrão para a appbar
    final appBarTheme = AppBarTheme(
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: Colors.white,
        fontSize: 18,
      ),
    );

    return ThemeData(
      textTheme: textTheme,
      colorScheme: colorScheme,
      appBarTheme: appBarTheme,
    );
  }
}