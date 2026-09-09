import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/brick.dart';
import 'brick_wall.dart';
import '../config/brick_size.dart';
import '../config/brick_color_pattern.dart';

/// Classe responsável por gerar a parede de blocos, instanciando
/// os blocos (Brick) com suas respectivas posições.
/// Uso de métodos estáticos, que recebem os parâmetros necessários.
class LevelMaker {

  /// Atribui uma das cores do padrão selecionado para cada coluna,
  /// de forma aleatória.
  static Color _pickBrickColor(
    BrickColorPattern pattern,
    math.Random random,
  ) {
    return pattern.colors[random.nextInt(pattern.colors.length)];
  }

  /// Gera o conjunto de objetos Brick representando a parede de blocos.
  /// Delega o cálculo das medidas dos blocos para o construtor
  /// da classe BrickWall, com base na largura disponível e
  /// no tamanho dos blocos (selecionado pelo usuário).
  static List<Brick> generateLevel({
    required int level,
    required double maxWidth,
    required BrickSize brickSize,
    required BrickColorPattern colorPattern,
    math.Random? random,
  }) {
    // delega o cálculo das medidas dos blocos e espaçamentos da parede
    // para a classe responsável.
    final brickWall = BrickWall(
        maxWidth: maxWidth,
        brickSize: brickSize
    );

    // instancia o obj random, se ele for nulo.
    random ??= math.Random();

    // Parede completa para o nível 1, e aleatório para os outros níveis.
    final map = level == 1
        ? List.filled(brickWall.rows, List.filled(brickWall.columns, true))
        : createRandomizedMap(brickWall.rows, brickWall.columns, random);

    final bricks = <Brick>[];

    // Utilizamos o layout da parede de blocos ("map") para instanciar
    // os objetos Brick, com as posições baseadas na linha e na coluna
    // em que estão.
    for (int r = 0; r < map.length; r++) {
      for (int c = 0; c < map[r].length; c++) {
        if (map[r][c]) {
          bricks.add(Brick(
            position: Vector2(
              // x
              (c + 0.5) * brickWall.brickWidth +
                  (c + 1) * brickWall.horizontalGutter,
              // y
              (r + 2.0) * brickWall.brickHeight +
                  (r + 1) * brickWall.verticalGutter,
            ),
            color: _pickBrickColor(colorPattern, random),
            width: brickWall.brickWidth,
            height: brickWall.brickHeight,
          ));
        }
      }
    }

    return bricks;
  }

  /// Constrói o layout da parede de blocos, de forma aleatória para metade
  /// de cada linha, e espelhando para a outra metade, e então retornando
  /// uma matriz de booleanos, indicando onde deve (ou não) haver blocos.
  static List<List<bool>> createRandomizedMap(
    int rows,
    int cols,
    math.Random random,
  ) {
    final map = <List<bool>>[];

    final halfCols = cols ~/ 2;

    // se tiver número ímpar de colunas
    final hasCenter = cols % 2 != 0;

    for (int r = 0; r < rows; r++) {
      final row = List.filled(cols, false);

      // Quantidade de pares que serão preenchidos
      final numPairs = random.nextInt(halfCols + 1);

      int placed = 0;

      while (placed < numPairs) {
        final idx = random.nextInt(halfCols);

        if (row[idx]) continue;

        // Lado esquerdo
        row[idx] = true;

        // Lado direito (espelhado)
        row[cols - 1 - idx] = true;

        placed++;
      }

      // Se houver uma coluna central, ela é "independente".
      if (hasCenter) {
        final center = halfCols;

        row[center] = random.nextBool();
      }

      map.add(row);
    }

    return map;
  }
}