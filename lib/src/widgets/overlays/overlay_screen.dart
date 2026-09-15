import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Animação que apresenta um título e um subtítulo "por cima" da tela,
/// baseada na desenvolvida no codelab, com a biblioteca flutter_animate.
class OverlayScreen extends StatelessWidget {
  const OverlayScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.textColor,
  });

  final String title;
  final String subtitle;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      alignment: const Alignment(0, -0.15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: textTheme.headlineLarge?.copyWith(
              color: textColor,
            ),
          ).animate().slideY(
            duration: 750.ms,
            begin: -3,
            end: 0,
          ),

          const SizedBox(height: 16),

          Text(
            subtitle,
            style: textTheme.headlineSmall?.copyWith(
              color: textColor,
            ),
          )
            .animate(onPlay: (controller) => controller.repeat())
            .fadeIn(duration: 1.seconds)
            .then()
            .fadeOut(duration: 1.seconds),
        ],
      ),
    );
  }
}
