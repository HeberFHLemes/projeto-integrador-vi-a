import 'dart:async';

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

  void startGame() {

    world.removeAll(world.children.query<Brick>());

    level = LevelMaker.generateLevel(
        level: currentLevel,
        maxWidth: gameWidth,
        brickSize: brickSize,
        colorPattern: brickColorPattern
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