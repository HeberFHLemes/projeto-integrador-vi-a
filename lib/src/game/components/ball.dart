import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/widgets.dart';

import 'paddle.dart';
import 'play_area.dart';
import 'brick.dart';
import '../breakout.dart';
import '../../app/app_theme.dart';

/// Componente da bola de jogo, com o gerenciamento de 
/// sua posição e movimento próprio.
class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<Breakout> {

  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
    radius: radius,
    anchor: Anchor.center,
    paint: Paint()
      ..color = AppTheme.primaryColor
      ..style = PaintingStyle.fill,
    children: [CircleHitbox()],
  );

  // para movimentar nos eixos x e y
  final Vector2 velocity;
  
  // aumento progressivo da velocidade
  final double difficultyModifier;

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is PlayArea) { // se for uma borda (da tela)
      final x = intersectionPoints.first.x;
      final y = intersectionPoints.first.y;

      if (x <= 0 || x >= game.width) {
        velocity.x = -velocity.x;
      }

      if (y <= 0) {
        velocity.y = -velocity.y;
      
      } else if (y >= game.height) { // se a bola passar do paddle
        add(
          RemoveEffect(
            delay: 0.35,
            onComplete: () {
              game.playState = PlayState.gameOver;
            }
          )
        );
      }
    } else if (other is Paddle) { // se for rebatida pelo paddle

      // som de rebatida no paddle
      FlameAudio.play('paddle_hit.wav');

      // inverte a direção vertical
      velocity.y = -velocity.y;

      // direção no eixo x calculada com base na posição de ambos (ball e paddle)
      velocity.x = velocity.x + (position.x - other.position.x) /
        other.size.x * game.width * 0.3;

    } else if (other is Brick) { // se acertar um bloco

      // diferença entre os centros nos eixos x e y dos dois componentes
      final offsetX = other.center.x - center.x;
      final offsetY = other.center.y - center.y;

      // profundidade da colisão nos eixos x e y (se a bola se sobrepôs ao bloco)
      final px = (other.width / 2) + radius - offsetX.abs();
      final py = (other.height / 2) + radius - offsetY.abs();

      // reflete a bola no eixo de menor "sobreposição" e 
      // então corrige a posição dela
      if (px < py) {
        velocity.x = -velocity.x;
        position.x = position.x + (offsetX > 0 ? -px : px);
      
      } else {
        velocity.y = -velocity.y;
        position.y = position.y + (offsetY > 0 ? -py : py);
      }
      
      // por fim se aumenta a velocidade
      velocity.setFrom(velocity * difficultyModifier);
    }
  }
}
