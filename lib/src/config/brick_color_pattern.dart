import 'package:flutter/material.dart';

import '../app/app_theme.dart';

/// Padrões de cores para a parede de blocos
enum BrickColorPattern {
  classico, colorido, brasil
}

/// Padrões de cores para os blocos
extension BrickColorPatternExtension on BrickColorPattern {
  List<Color> get colors {
    return switch (this) {
      BrickColorPattern.classico => [
        // mesmas que o padrão de cores do app, mais um tom de vermelho
        AppTheme.primaryColor,
        AppTheme.secondaryColor,
        AppTheme.tertiaryColor,
        const Color(0xffd92940),
      ],
      BrickColorPattern.colorido => [
        const Color(0xfff94144),
        const Color(0xfff9844a),
        const Color(0xfff8961e),
        const Color(0xfff9c74f),
        const Color(0xff4d908e),
        const Color(0xff577590),
      ],
      BrickColorPattern.brasil => [
        const Color(0xff009C3B),
        const Color(0xffFFDF00),
        const Color(0xff002776),
        Colors.white,
      ],
    };
  }
}