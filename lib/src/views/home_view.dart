import 'package:flutter/material.dart';

import '../config/game_options.dart';
import '../widgets/app_button.dart';

/// Tela inicial do App
class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    this.options = const GameOptions(),
  });

  final GameOptions options;

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late GameOptions _options;

  @override
  void initState() {
    super.initState();

    // Obtendo as opções selecionadas
    _options = widget.options;
  }

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
                        onPressed: () async {
                          final result = await Navigator.pushNamed(
                            context,
                            '/options',
                            arguments: _options,
                          );

                          // Recebe as alterações feitas pelo usuário.
                          if (result is GameOptions) {
                            setState(() {
                              _options = result;
                            });
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