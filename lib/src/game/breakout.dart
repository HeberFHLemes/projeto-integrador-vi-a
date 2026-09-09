import 'dart:async';
import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../config/brick_color_pattern.dart';
import '../config/brick_size.dart';
import 'components/brick.dart';
import 'components/play_area.dart';
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
    this.brickSize = BrickSize.medium,
    this.brickColorPattern = BrickColorPattern.classico,
  }) : super(
    camera: CameraComponent.withFixedResolution(
      width: gameWidth,
      height: gameHeight,
    ),
  );

  final ValueNotifier<int> score = ValueNotifier(0);
  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  /// Tamanho dos blocos selecionado
  BrickSize brickSize;

  /// Padrão de cores selecionado para a parede de blocos
  BrickColorPattern brickColorPattern;

  /// Nível atual
  int currentLevel = 1;

  /// Parede de blocos que representa o nível atual
  late List<Brick> level;

  // Gerenciamento dos estados do jogo
  late PlayState _playState;

  PlayState get playState => _playState;

  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      // TODO: gerenciar estados de welcome, gameOver e won apropriadamente...
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

  // TODO:
  // - Gerenciar os estados
  // - Adicionar/remover objetos do "mundo"/world
  // - Eventos de interação do usuário
  // - Usar efeitos sonoros em certas ações
  // - Gerenciar os níveis

  void startGame() {
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<Brick>());

    playState = PlayState.playing;
    score.value = 0;

    level = LevelMaker.generateLevel(
      level: currentLevel,
      maxWidth: gameWidth,
      brickSize: brickSize,
      colorPattern: brickColorPattern,
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
        // TODO: movimento p/ esquerda
      case LogicalKeyboardKey.arrowRight:
        // TODO: movimento p/ direita
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.enter:
        startGame();
    }
    return KeyEventResult.handled;
  }
}