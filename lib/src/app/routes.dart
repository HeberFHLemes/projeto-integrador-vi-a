import 'package:flutter/material.dart';

import '../config/game_options.dart';
import '../views/views.dart';

/// Registro das rotas do aplicativo
final routes = {
  '/': (context) => HomeView(),
  '/credits': (context) => CreditsView(),
  '/game': (context) => GameView(),
  '/options': (context) {
    // recebendo e repassando opções selecionadas pelo usuário
    final options = ModalRoute.of(context)!
        .settings.arguments as GameOptions;

    return OptionsView(options: options);
  },
};
