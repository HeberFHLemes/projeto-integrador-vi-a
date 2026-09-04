import 'package:breakout/src/game/breakout.dart';
import 'package:breakout/src/game/constants.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
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