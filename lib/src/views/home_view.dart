import 'package:flutter/material.dart';

import '../config/game_options.dart';
import '../widgets/app_button.dart';


/// Tela inicial do App
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // TODO:
  //  refatorar para stateful;
  //  receber gameoptions de volta da OptionsView;
  //  receber como parâmetro ou instanciar;
  final GameOptions _options = const GameOptions();

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
                          Navigator.pushNamed(
                            context,
                            '/game',
                            arguments: _options,
                          );
                        }
                      ),
                      AppButton(
                        text: 'Opções',
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        textColor: Colors.white,
                        onPressed: () {
                          final result = Navigator.pushNamed(
                            context,
                            '/options',
                            arguments: _options,
                          );

                          if (result is GameOptions) {
                            // TODO: receber as opções selecionadas
                          }
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