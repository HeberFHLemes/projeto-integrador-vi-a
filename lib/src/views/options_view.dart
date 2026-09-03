import 'package:flutter/material.dart';

/// Tela de configuração da parede de blocos por parte do usuário,
/// por enquanto como stateless, podendo ser adaptado para stateful,
/// de acordo com a implementação da passagem das opções entre as views/telas.
class OptionsView extends StatelessWidget {
  const OptionsView({super.key});

  // TODO: opções selecionadas do padrão de cores e tamanho dos blocos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO:
      // - AppBar com nome 'Opções'
      // - Título/header em destaque 'Parede de blocos'
      // - Opções de configuração do padrão de cores (DropdownMenu)
      // - Opções de configuração do tamanho dos blocos (SegmentedButton)
      // - Botão 'Voltar'
    );
  }
}