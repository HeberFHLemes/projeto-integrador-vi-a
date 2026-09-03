import 'package:flutter/material.dart';

/// Tela com o nome dos integrantes do grupo
class CreditsView extends StatelessWidget {
  const CreditsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // app bar (com nome da tela/página)
        title: Text(
            'Créditos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            )
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false, // sem o ícone padrão
      ),
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