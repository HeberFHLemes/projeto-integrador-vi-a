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

  // TODO:
  // - Gerenciar os estados
  // - Adicionar/remover objetos do "mundo"/world
  // - Eventos de interação do usuário
  // - Usar efeitos sonoros em certas ações
  // - Gerenciar os níveis
}