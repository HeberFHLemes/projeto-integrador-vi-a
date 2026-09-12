import 'package:flutter/material.dart';

import '../config/brick_color_pattern.dart';
import '../config/brick_size.dart';
import '../config/game_options.dart';
import '../widgets/brick_size_button.dart';
import '../widgets/color_pattern_dropdown.dart';
import '../widgets/custom_app_bar.dart';

/// Tela de configuração da parede de blocos por parte do usuário.
class OptionsView extends StatefulWidget {
  const OptionsView({
    super.key,
    // required this.options,
  });

  // TODO: receber as opções selecionadas como parâmetro
  // por enquanto instanciando aqui!
  final GameOptions options = const GameOptions();

  @override
  State<StatefulWidget> createState() => _OptionsViewState();
}

class _OptionsViewState extends State<OptionsView> {

  late BrickSize _selectedSize;
  late BrickColorPattern _selectedColorPattern;

  @override
  void initState() {
    super.initState();

    // Obtendo as opções selecionadas
    _selectedSize = widget.options.brickSize;
    _selectedColorPattern = widget.options.brickColorPattern;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Opções'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.all(20),
          child: Column(
            spacing: 4,
            children: [
              // espaço adicional entre a appbar e o "título"
              const SizedBox(height: 32),
              
              // Título/header em destaque "Parede de blocos"
              Center(
                child: const Text(
                  'Parede de blocos',
                  style: TextStyle(fontSize: 20),
                )
              ),

              // Dropdown com as opções de padrão de cores
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(top: 16),
                    child: ColorPatternDropdown(
                      selectedColor: _selectedColorPattern,
                      onChanged: (pattern) {
                        setState(() {
                          _selectedColorPattern = pattern;
                        });
                      }
                    ),
                  ),
                ),
              ),

              // Espaço adicional entre os componentes de configuração
              const SizedBox(height: 20),

              // Botões (SegmentedButton) para escolher os tamanhos dos blocos
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(
                        child: const Text('Tamanho dos blocos'),
                      ),
                    ),

                    BrickSizeButton(
                      selectedSize: _selectedSize,
                      onChanged: (size) {
                        setState(() {
                          _selectedSize = size;
                        });
                      },
                    )
                  ],
                ),
              ),

              // TODO: botão voltar
            ],
          )
        ),
      ),
    );
  }
}