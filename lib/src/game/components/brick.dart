import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../breakout.dart';
import '../../app/app_theme.dart';
import '../../config/brick_color_pattern.dart';

/// Componente que representa os blocos
class Brick extends RectangleComponent
  with CollisionCallbacks, HasGameReference<Breakout> {

  Brick({
    required super.position,
    required Color color,
    required double width,
    required double height,
  }) : super(
    size: Vector2(width, height),
    anchor: Anchor.center,
    paint: Paint()
      ..color = color
      ..style = PaintingStyle.fill,
    children: [RectangleHitbox()],
  );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    final isLastBrick = game.world.children.query<Brick>().length == 1;

    // remove bloco da tela
    removeFromParent();

    // aumenta a pontuação do usuário
    game.score.value++;

    // Se for o último bloco, usuário "venceu" o nível
    if (isLastBrick) {
      game.completeLevel();
    }
  }

  // Borda dos blocos
  final Paint _borderPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.4;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // cor da borda com base na cor de fundo do jogo
    _borderPaint.color = game.options.brickColorPattern.isDarkTheme
      ? Colors.white
      : AppTheme.secondaryColor;

    // Adicionando borda aos blocos para poder utilizar cores claras.
    canvas.drawRect(size.toRect(), _borderPaint);
  }
}