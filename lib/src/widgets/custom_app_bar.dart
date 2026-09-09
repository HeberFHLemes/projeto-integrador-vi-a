import 'package:flutter/material.dart';

/// Componente AppBar utilizado em diferentes telas, com características comuns.
class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  CustomAppBar({super.key, required this.title});

  /// Título (texto) apresentado no componente.
  String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 18)
      ),
      backgroundColor: Theme.of(context).colorScheme.primary, // fundo azul
      foregroundColor: Colors.white, // texto na cor branca
      centerTitle: true, // texto/título centralizado
      automaticallyImplyLeading: false, // sem ícone de voltar
    );
  }

  /// Para se comportar como componente AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}