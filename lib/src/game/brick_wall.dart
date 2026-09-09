import '../config/brick_size.dart';

/// Classe responsável por conter e calcular as medidas relativas à parede
/// de blocos, com base no tamanho de tela disponivel para tal e no tamanho
/// dos blocos selecionado.
class BrickWall {
  double minGutter = 6.0;

  int rows = 5; // por enquanto sempre 5

  // variáveis calculadas com base no tamanho do bloco escolhido e largura
  // máxima da tela a ser utilizada para a parede.
  late int columns;

  late double brickWidth;
  late double brickHeight;

  late double horizontalGutter;
  late double verticalGutter;

  BrickWall({
    required double maxWidth,
    required BrickSize brickSize
  }) : this.calculateForLayout(maxWidth, brickSize);

  /// Cálculo das propriedades definidas
  /// com base no tamanho dos blocos selecionado.
  BrickWall.calculateForLayout(
    double maxWidth, BrickSize brickSize
  ) {
    brickWidth = brickSize.width;
    brickHeight = brickWidth / 2;

    columns = ((maxWidth - minGutter) / (brickWidth + minGutter)).floor();

    horizontalGutter = (maxWidth - columns * brickWidth) / (columns + 1);
    verticalGutter = horizontalGutter * 0.75;
  }
}