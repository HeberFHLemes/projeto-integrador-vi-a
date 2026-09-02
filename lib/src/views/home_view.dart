import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
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

                // TODO: Botões para redirecionar para as respectivas telas...
                // Novo Jogo
                // Opções
                // Créditos
                Expanded(
                  child: Center(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text('Testando layout')
                        )
                      ]
                    )
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}