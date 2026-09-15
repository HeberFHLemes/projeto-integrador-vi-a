import 'package:flutter/material.dart';

import '../../game/breakout.dart';

/// Overlay que aparece por um certo tempo na tela do usuário quando ele
/// "vence" um nível, não sendo necessário fechar, pois será baseado em tempo.
class LevelWonOverlay extends StatelessWidget {
  const LevelWonOverlay({
    super.key,
    required this.game,
  });

  final Breakout game;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Align(
      // align para poder posicionar na parte de baixo da tela de jogo
      alignment: const Alignment(0, 0.65),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 64,
        ),
        decoration: BoxDecoration(
          color: Color.lerp( // suavizando o azul da cor primária com branco
            colorScheme.primary,
            Colors.white,
            0.9,
          ),
          border: Border.all( // pequena borda, mas sem sombra neste overlay
            color: colorScheme.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // texto em destaque
            Text(
              'NÍVEL CONCLUÍDO!',
              style: textTheme.headlineSmall?.copyWith(
                color: colorScheme.primary,
              ),
            ),

            const SizedBox(height: 32),

            // texto menor
            Text(
              'PRÓXIMO NÍVEL INICIANDO...',
              style: textTheme.titleMedium,
            ),

            // pequeno espaçamento no final como se fosse um padding
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}