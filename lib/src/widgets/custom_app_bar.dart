import 'package:flutter/material.dart';

/// Componente AppBar utilizado em diferentes telas.
class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {

  const CustomAppBar({super.key, required this.title});

  /// Widget que representará o título/texto apresentado no componente.
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      backgroundColor: Theme.of(context).colorScheme.primary, // fundo azul
      centerTitle: true, // texto/título centralizado
      automaticallyImplyLeading: false, // sem ícone de voltar
    );
  }

  /// Para se comportar como componente AppBar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}