import 'package:flutter/material.dart';

import '../widgets/app_button.dart';
import '../widgets/custom_app_bar.dart';

/// Tela com o nome dos integrantes do grupo
class CreditsView extends StatelessWidget {
  const CreditsView({super.key});

  // Lista de integrantes.
  static const List<String> _members = [
    'Héber Lemes',
    'Maicon Rodrigues',
    'Natanael Rocha',
    'Nicolas Farina',
    'Raphael Ribeiro',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: CustomAppBar(title: 'Créditos'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Conteúdo principal (título + lista), ocupando o espaço
              // disponível para que o botão fique fixo embaixo.
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Integrantes',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 64),

                    // Gera um Text para cada nome da lista.
                    ..._members.map(
                          (name) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: AppButton(
                    text: 'Voltar',
                    textColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).colorScheme.tertiary,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
