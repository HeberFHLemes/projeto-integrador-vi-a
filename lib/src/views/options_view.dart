import 'package:flutter/material.dart';

import '../config/brick_color_pattern.dart';
import '../config/brick_size.dart';
import '../config/game_options.dart';
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
            children: [
              // TODO: adicionar os componentes
            ],
          )
        ),
      ),
    );
  }
}