import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/brick_color_pattern.dart';
import '../config/game_options.dart';
import 'components/game_components.dart';
import 'constants.dart';
import 'level_maker.dart';

/// Estados do jogo
enum PlayState {
  welcome, // antes de "iniciar" o jogo
  playing, // enquanto joga
  gameOver, // modal "Você perdeu!" com as opções de reiniciar nível ou avançar
  won; // modal informando que usuário avançará p/ o próximo nível
}

/// Classe responsável pelo gerenciamento do jogo e seus componentes,
/// estendendo de FlameGame.
class Breakout extends FlameGame
  with HasCollisionDetection, KeyboardEvents, TapCallbacks {

  Breakout({
    required this.options
  }) : super(
    camera: CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
    ),
  );

  double get width => size.x;
  double get height => size.y;
  final rand = math.Random();

  /// Pontuação atual do usuário
  final ValueNotifier<int> score = ValueNotifier(0);

  /// Nível atual
  final ValueNotifier<int> currentLevel = ValueNotifier(1);

  /// Opções do jogo (padrão de cores e tamanho dos blocos)
  final GameOptions options;

  /// Parede de blocos que representa o nível atual
  late List<Brick> level;

  // Gerenciamento dos estados do jogo
  late PlayState _playState;

  PlayState get playState => _playState;

  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;
  }

  void startGame() {
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Brick>());
    world.removeAll(world.children.query<Paddle>());

    playState = PlayState.playing;
    score.value = 0;
    // TODO: adicionar efeito sonoro de ínicio de nível

    world.add(
      Ball(
        position: size / 2, // começa no meio da tela
        radius: ballRadius,
        difficultyModifier: difficultyModifier,
        velocity: Vector2(
          (rand.nextDouble() - 0.5) * width,
          height * 0.2,
        ).normalized()..scale(height / 4),
      )
    );

    // criação do paddle para o usuário controllar,
    // com base nas constantes definidas
    world.add(
      Paddle(
        size: Vector2(paddleWidth, paddleHeight),
        cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95),
      ),
    );

    level = LevelMaker.generateLevel(
      level: currentLevel.value,
      maxWidth: gameWidth,
      brickSize: options.brickSize,
      colorPattern: options.brickColorPattern,
      random: rand
    );

    world.addAll(level);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    startGame();
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event,
      Set<LogicalKeyboardKey> keysPressed,
      ) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Paddle>().first.moveBy(-paddleStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Paddle>().first.moveBy(paddleStep);
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.enter:
        startGame();
    }
    return KeyEventResult.handled;
  }

  @override
  Color backgroundColor() {
    return options.brickColorPattern.isDarkTheme
      ? Colors.black
      : Colors.white;
  }
}
