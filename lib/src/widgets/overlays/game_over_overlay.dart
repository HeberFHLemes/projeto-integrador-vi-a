import 'package:flutter/material.dart';

import '../../game/breakout.dart';

/// Overlay para quando o usuário deixar a bola passar do paddle ("perder"),
/// com as opções de reiniciar o mesmo nível ou avançar de nível.
class GameOverOverlay extends StatelessWidget {
  const GameOverOverlay({
    super.key,
    required this.game,
  });

  final Breakout game;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Stack(
      children: [
        Center(
          child: Container(
            width: 600,
            height: 400,
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all( // com borda
                color: colorScheme.primary,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(8),
              // com sombra, para constraste com a tela de jogo
              boxShadow: [
                BoxShadow(
                  color: colorScheme.secondary,
                  blurRadius: 24,
                  spreadRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Texto em destaque
                Text(
                  'VOCÊ PERDEU!',
                  style: textTheme.headlineLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 20),

                // texto menor
                Text(
                  'O QUE DESEJA FAZER?',
                  style: textTheme.headlineSmall,
                ),

                const SizedBox(height: 32),

                // conjunto de opções (botões), dispostos verticalmente
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // reiniciar mesmo nível
                      _GameOverButton(
                        label: 'JOGAR DE NOVO',
                        backgroundColor: colorScheme.primary,
                        foregroundColor: Colors.white,
                        onPressed: game.restartLevel,
                      ),

                      const SizedBox(height: 16),

                      // avançar para o próximo
                      _GameOverButton(
                        label: 'PRÓXIMO NÍVEL',
                        backgroundColor: colorScheme.tertiary,
                        foregroundColor: colorScheme.primary,
                        onPressed: game.nextLevel,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Botões utilizados no modal
class _GameOverButton extends StatelessWidget {
  const _GameOverButton({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.onPressed,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: Text(label),
      ),
    );
  }
}