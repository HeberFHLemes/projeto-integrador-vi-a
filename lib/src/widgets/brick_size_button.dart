import 'package:flutter/material.dart';

import '../config/brick_size.dart';

/// Botão para escolha do tamanho dos blocos, sendo um SegmentedButton.
class BrickSizeButton extends StatelessWidget {
  
  const BrickSizeButton({
    super.key,
    required this.selectedSize,
    required this.onChanged,
  });

  final BrickSize selectedSize;
  final ValueChanged<BrickSize> onChanged;

  @override
  Widget build(BuildContext context) {

    return SegmentedButton<BrickSize>(
      selectedIcon: const SizedBox.shrink(), // sem ícone
      selected: {selectedSize}, // opção selecionada
      segments: [
        // Uso dos valores do enum para construir as opções.
        for (final size in BrickSize.values)
          ButtonSegment(
            value: size, // valor do enum
            label: Text( // texto apresentado ao usuário
              size.label,
              style: TextStyle(fontSize: 10),
              maxLines: 1,
            ),
          ),
      ],
      onSelectionChanged: (selected) {
        onChanged(selected.first);
      },
      style: ButtonStyle( // aparência do botão
        minimumSize: const WidgetStatePropertyAll(
          Size(70, 40),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          return states.contains(WidgetState.selected)
              ? Theme.of(context).colorScheme.primary
              : Colors.white;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          return states.contains(WidgetState.selected)
              ? Colors.white
              : Theme.of(context).colorScheme.secondary;
        }),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder( // Formato retangular
            borderRadius: BorderRadius.zero,
          ),
        ),
      ),
    );
  }
}