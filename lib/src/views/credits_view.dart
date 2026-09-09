import 'package:breakout/src/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

/// Tela com o nome dos integrantes do grupo
class CreditsView extends StatelessWidget {
  const CreditsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Créditos'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // TODO: título/header em destaque "Integrantes"

              // TODO: Listagem dos nomes dos integrantes

              // TODO: Botão "Voltar" (AppButton)
            ],
          ),
        ),
      ),
    );
  }
}