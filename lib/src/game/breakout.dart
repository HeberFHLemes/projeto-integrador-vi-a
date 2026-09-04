import 'dart:async';

import 'package:breakout/src/game/components/play_area.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

import 'constants.dart';

/// Classe responsável pelo gerenciamento do jogo e seus componentes,
/// estendendo de FlameGame.
class Breakout extends FlameGame
  with HasCollisionDetection, KeyboardEvents, TapCallbacks {

  Breakout() : super(
    camera: CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
    ),
  );

  double get width => size.x;
  double get height => size.y;

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    // TODO: definir estado inicial
  }

  // TODO:
  // - Gerenciar os estados
  // - Adicionar/remover objetos do "mundo"/world
  // - Eventos de interação do usuário
  // - Usar efeitos sonoros em certas ações
  // - Gerenciar os níveis
}