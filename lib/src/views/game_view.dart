import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../config/brick_color_pattern.dart';
import '../config/game_options.dart';
import '../game/breakout.dart';
import '../game/constants.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/overlays/overlays.dart';

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
      // TODO: appbar atualizar o nível atual
      appBar: CustomAppBar(
        // para poder atualizar o valor
        title: ValueListenableBuilder<int>(
          valueListenable: game.currentLevel,
          builder: (_, level, _) => Text('NÍVEL $level'),
        ),
      ),
      body: SafeArea(
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
                      child: Container(
                        // pequena borda para identificar paredes do jogo
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 1,
                          ),
                        ),
                        child: GameWidget(
                          game: game,
                          overlayBuilderMap: _overlays(
                            // Cor do texto com base na cor de fundo do jogo
                            textColor:
                              widget.options.brickColorPattern.isDarkTheme
                                ? Colors.white
                                : Theme.of(context).colorScheme.secondary
                          ),
                          initialActiveOverlays: const ['score'],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  /// Textos, modais e informações sobrepostas à tela de jogo,
  /// de acordo com os diferentes estados do jogo.
  Map<String, Widget Function(BuildContext, Breakout)>? _overlays({
    required Color textColor
  }) {
    return {
      // Antes de começar de fato o jogo
      PlayState.welcome.name: (context, Breakout game) =>
        OverlayScreen(
          title: 'TOQUE PARA COMEÇAR',
          subtitle: '',
          textColor: textColor,
        ),

      // Modal apresentado quando o usuário "perde" um nível,
      // mostrando as opções de reiniciar nível ou avançar pro próximo.
      PlayState.gameOver.name: (context, Breakout game) =>
        GameOverOverlay(game: game),

      // Modal de nível concluído
      PlayState.won.name: (context, Breakout game) {
        return LevelWonOverlay(game: game);
      },

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
                style: TextStyle(
                  fontSize: 20,
                  color: textColor,
                ),
              );
            },
          ),
        );
      },
    };
  }
}