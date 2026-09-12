import 'package:flutter/material.dart';

import '../config/brick_color_pattern.dart';

// Componente do tipo DropdownMenu para escolha do padrão de cores
/// da parede de blocos.
class ColorPatternDropdown extends StatelessWidget {

  const ColorPatternDropdown({
    super.key,
    required this.selectedColor,
    required this.onChanged,
  });

  final BrickColorPattern selectedColor;
  final ValueChanged<BrickColorPattern> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<BrickColorPattern>(
      initialSelection: selectedColor,
      label: const Text('Padrão de cores'),
      dropdownMenuEntries: [
        // Para cada valor do enum, uma opção no dropdown, com seu nome
        for (final pattern in BrickColorPattern.values)
          DropdownMenuEntry(
            value: pattern,
            label: pattern.label,
          ),
      ],
      enableSearch: false,
      requestFocusOnTap: false,
      onSelected: (BrickColorPattern? value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}