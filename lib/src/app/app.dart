import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../views/home_view.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Fonte "Press Start 2P", do Google Fonts.
        textTheme: GoogleFonts.pressStart2pTextTheme().apply(
          bodyColor: const Color(0xff404042),
          displayColor: const Color(0xff404042),
        ),
      ),
      routes: routes,
      home: const HomeView(), // tela inicial
    );
  }
}
