import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../game/breakout.dart';
import '../game/constants.dart';
import '../widgets/custom_app_bar.dart';

class GameView extends StatefulWidget {

  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  late final Breakout game;

  @override
  void initState() {
    super.initState();
    game = Breakout();
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
                  // TODO: Score/pontuação do usuário
                  Expanded(
                    child: FittedBox(
                      child: SizedBox(
                        width: gameWidth,
                        height: gameHeight,
                        child: GameWidget(
                          game: game,
                          // mostrando a info de pontos do usuário (score)
                          overlayBuilderMap: {
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
                                      'Pontos: $score',
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
                          // TODO: gerenciar estados diferentes do jogo.
                          // 1 - Ao receber o usuário ou início de nível
                          // 2 - Ao usuário "perder" -> reiniciar nível ou passar
                          // 3 - Passar de nível ou completar níveis
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