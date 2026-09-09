import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../app/app_theme.dart';
import '../breakout.dart';

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

    // TODO: lidar com as colisões
  }

  // Borda dos blocos
  final Paint _borderPaint = Paint()
    ..color = AppTheme.secondaryColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.4;

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Adicionando borda aos blocos para poder utilizar cores claras.
    canvas.drawRect(size.toRect(), _borderPaint);
  }
}