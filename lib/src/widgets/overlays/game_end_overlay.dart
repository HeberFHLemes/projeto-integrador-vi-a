import 'package:flutter/material.dart';

/// Componente que representará o modal de fim de jogo,
/// seja ao perder ou atingir o final do último nível.
class GameEndOverlay extends StatelessWidget {
  const GameEndOverlay({
    super.key,
    required this.title,
    required this.subtitle,
    required this.actions,
  });

  final String title;
  final String subtitle;

  final List<GameEndButton> actions;

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
                  title,
                  style: textTheme.headlineLarge?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 20),

                // texto menor
                Text(
                  subtitle,
                  style: textTheme.headlineSmall,
                ),

                const SizedBox(height: 32),

                // conjunto de opções (botões), dispostos verticalmente
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: actions,
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

/// Botões utilizados no modal de fim de jogo/nível
class GameEndButton extends StatelessWidget {
  const GameEndButton({
    super.key,
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