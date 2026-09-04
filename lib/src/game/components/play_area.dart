import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../breakout.dart';

/// Componente relativo à "área de jogo", contendo os "limites" da tela de jogo.
class PlayArea extends RectangleComponent with HasGameReference<Breakout> {
  PlayArea() : super(children: [RectangleHitbox()]);

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}