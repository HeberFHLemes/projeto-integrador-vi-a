import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../config/game_options.dart';
import '../game/breakout.dart';
import '../game/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/overlay_screen.dart';

class GameView extends StatefulWidget {

  const GameView({
    super.key,
    this.options = const GameOptions(),
  });

  final GameOptions options;

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final Breakout game;

  @override
  void initState() {
    super.initState();
    game = Breakout(options: widget.options);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'NÍVEL ${game.currentLevel}'),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: FittedBox(
                      child: SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: GameWidget(
                          game: game,
                          overlayBuilderMap: {
                            PlayState.welcome.name: (context, game) =>
                              const OverlayScreen(
                                title: 'TOQUE PARA COMEÇAR',
                                subtitle: '',
                              ),
                            PlayState.gameOver.name: (context, game) =>
                              // TODO: modal com opções as reiniciar ou avançar
                              const OverlayScreen(
                                title: 'VOCÊ PERDEU!',
                                subtitle: 'Tap to Play Again',
                              ),
                            PlayState.won.name: (context, game) =>
                              // TODO:
                              // - Modal informativo (nível concluído
                              // - Se estiver no último nível:
                              // completar ou continuar até o usuário perder?
                              const OverlayScreen(
                                title: 'NÍVEL CONCLUÍDO',
                                subtitle: 'PRÓXIMO NÍVEL INICIANDO',
                              ),

                            // mostrando a pontuação do usuário (score)
                            'score': (context, Breakout game) {
                              // no topo, à esquerda, com pequeno padding
                              return Positioned(
                                top: 16,
                                left: 16,
                                child: ValueListenableBuilder<int>(
                                  valueListenable: game.score,
                                  builder: (context, score, child) {
                                    // texto em si
                                    return Text(
                                      'Pontos: ${
                                        // pelo menos três 'dígitos'
                                        score.toString().padLeft(3, '0')
                                      }',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          },
                          initialActiveOverlays: const ['score'],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}