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
  welcome, // antes de "iniciar" o nível
  playing, // enquanto joga
  gameOver, // usuário "perdeu" (opções de reiniciar nível ou avançar)
  won; // usuário completou o nível
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

  /// Para redefinir pontuação se usuário quiser reiniciar o nível
  int scoreAtLevelStart = 0;

  /// Opções do jogo (padrão de cores e tamanho dos blocos)
  final GameOptions options;

  /// Parede de blocos que representa o nível atual
  late List<Brick> level;

  // Gerenciamento dos estados do jogo
  late PlayState _playState;

  PlayState get playState => _playState;

  set playState(PlayState playState) {
    _playState = playState;

    // removendo os overlays dos estados
    overlays.remove(PlayState.welcome.name);
    overlays.remove(PlayState.gameOver.name);
    overlays.remove(PlayState.won.name);

    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
      // jogo executando...
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    // (re)define variáveis e já chama a construção da parede
    setupGame();

    playState = PlayState.welcome;
  }

  /// Prepara um novo jogo (nível 1)
  void setupGame() {
    currentLevel.value = 1;
    score.value = 0;

    generateNewLevel();
  }

  /// Gera nova parede de blocos com base no nível atual,
  /// tamanho de tela, e configurações feitas pelo usuário.
  void generateNewLevel() {
    level = LevelMaker.generateLevel(
        level: currentLevel.value,
        maxWidth: gameWidth,
        brickSize: options.brickSize,
        colorPattern: options.brickColorPattern,
        random: rand
    );
  }

  /// Para ser utilizado na opção avançar nível (no modal)
  void nextLevel() {
    currentLevel.value++;

    generateNewLevel();

    playState = PlayState.welcome;
  }

  /// Para ser utilizado na opção reiniciar nível (no modal)
  void restartLevel() {
    // redefine a pontuação para quando o usuário iniciou o nível
    score.value = scoreAtLevelStart;

    playState = PlayState.welcome;
  }

  /// Inicia o nível atual, adicionando componentes de jogo na tela.
  void startLevel() {
    if (playState == PlayState.playing) return;

    clearLevel();

    playState = PlayState.playing;
    scoreAtLevelStart = score.value;

    // TODO: reproduzir som de início da fase

    // criação da bola
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

    world.addAll(level);
  }

  /// Quando o usuário concluir o nível, avançando para o próximo.
  Future<void> completeLevel() async {
    if (playState != PlayState.playing) return;

    clearLevel();

    playState = PlayState.won;

    // modal fica apenas por um tempo na tela
    await Future.delayed(const Duration(seconds: 2));

    nextLevel();
  }

  /// Remove os componentes de jogo da tela
  void clearLevel() {
    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Brick>());
    world.removeAll(world.children.query<Paddle>());
  }

  /// Responsável por definir as ações para cada estado
  void handleState() {
    if (playState == PlayState.welcome) {
      startLevel();
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    handleState();
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
        handleState();
    }
    return KeyEventResult.handled;
  }

  /// Cor de fundo do jogo, com base no padrão de cores selecionado.
  @override
  Color backgroundColor() {
    return options.brickColorPattern.isDarkTheme
      ? Colors.black
      : Colors.white;
  }
}
