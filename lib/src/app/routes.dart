import 'package:flutter/material.dart';

import '../config/game_options.dart';
import '../views/views.dart';

/// Registro das rotas do aplicativo
final routes = {
  '/': (context) {
    // recebendo e repassando opções selecionadas pelo usuário
    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      return HomeView(options: args as GameOptions);
    }

    // Ao iniciar o app
    return HomeView();
  },
  '/credits': (context) => CreditsView(),
  '/game': (context) {
    final options = ModalRoute.of(context)!
        .settings.arguments as GameOptions;

    return GameView(options: options);
  },
  '/options': (context) {
    // recebendo e repassando opções selecionadas pelo usuário
    final options = ModalRoute.of(context)!
        .settings.arguments as GameOptions;

    return OptionsView(options: options);
  },
};
