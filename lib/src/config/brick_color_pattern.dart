import 'package:flutter/material.dart';

import '../app/app_theme.dart';

/// Padrões de cores para a parede de blocos
enum BrickColorPattern {
  classico,
  classicoEscuro,
  colorido,
  coloridoEscuro,
  brasil,
}

/// Padrões de cores para os blocos
extension BrickColorPatternExtension on BrickColorPattern {
  List<Color> get colors {
    return switch (this) {
      BrickColorPattern.classico || BrickColorPattern.classicoEscuro => [
        // inspirado nas cores do app, mais um tom de vermelho
        AppTheme.primaryColor,
        AppTheme.secondaryColor,
        Colors.white,
        const Color(0xffd92940),
      ],
      BrickColorPattern.colorido || BrickColorPattern.coloridoEscuro => [
        const Color(0xff147AF2),
        const Color(0xff27AE60),
        const Color(0xffFF4FA3),
        const Color(0xffE63946),
        const Color(0xffF2C94C),
      ],
      BrickColorPattern.brasil => [
        const Color(0xff009C3B),
        const Color(0xffFFDF00),
        const Color(0xff002776),
        Colors.white,
      ],
    };
  }

  /// Texto a ser apresentado ao usuário para representar cada padrão.
  String get label {
    return switch (this) {
      BrickColorPattern.classico => 'Clássico',
      BrickColorPattern.classicoEscuro => 'Clássico Escuro',
      BrickColorPattern.colorido => 'Colorido',
      BrickColorPattern.coloridoEscuro => 'Colorido Escuro',
      BrickColorPattern.brasil => 'Brasil',
    };
  }

  bool get isDarkTheme {
    return switch (this) {
      BrickColorPattern.classicoEscuro => true,
      BrickColorPattern.coloridoEscuro => true,
      _ => false,
    };
  }
}