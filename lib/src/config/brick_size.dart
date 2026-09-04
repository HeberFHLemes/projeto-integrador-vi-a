const baseBrickWidth = 72.0;

/// Tamanho dos blocos
enum BrickSize {
  small,
  medium,
  large;
}

// "Extension" em Dart: https://dart.dev/language/extension-methods
extension BrickSizeExtension on BrickSize {
  // Cálculo das larguras dos blocos
  double get width {
    switch (this) {
      case BrickSize.small:
        return baseBrickWidth * 0.85;
      case BrickSize.medium:
        return baseBrickWidth;
      case BrickSize.large:
        return baseBrickWidth * 1.25;
    }
  }

  // Texto que é apresentado ao usuário referente a cada tamanho.
  String get label {
    return switch (this) {
      BrickSize.small => "Pequeno",
      BrickSize.medium => "Médio",
      BrickSize.large => "Grande",
    };
  }
}