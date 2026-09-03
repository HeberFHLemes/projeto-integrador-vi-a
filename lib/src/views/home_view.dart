import 'package:flutter/material.dart';

import '../widgets/app_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Título/header, em destaque
              Expanded(
                child: Center(
                  child: Text(
                    'Breakout',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Center(
                  child: Column(
                    spacing: 16.0,
                    children: [
                      AppButton(
                        text: 'Novo Jogo',
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        textColor: Colors.white,
                        onPressed: () {
                          // TODO: redirecionar para tela de jogo (nível 1) e
                          // passar configuração selecionada da parede de blocos
                        }
                      ),
                      AppButton(
                        text: 'Opções',
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        onPressed: () {
                          // TODO: passar parâmetros relativos às
                          //  opções selecionadas (e repassar ao jogo depois).
                          Navigator.pushNamed(context, '/options');
                        }
                      ),
                      AppButton(
                          text: 'Créditos',
                          textColor: Theme.of(context).colorScheme.secondary,
                          backgroundColor: Theme.of(context).colorScheme.tertiary,
                          onPressed: () {
                            Navigator.pushNamed(context, '/credits');
                          }
                      ),
                    ]
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}