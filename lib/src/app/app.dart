import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      routes: routes,
      initialRoute: '/',
    );
  }
}
