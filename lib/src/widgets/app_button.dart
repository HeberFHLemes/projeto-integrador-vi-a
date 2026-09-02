import 'package:flutter/material.dart';

/// Widget que representa os botões utilizados nas telas iniciais,
/// recebendo o texto, cor do texto, cor de fundo e a ação a ser realizada
/// ao pressioná-lo como parâmetros.
class AppButton extends StatelessWidget {

  const AppButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    this.onPressed,
  });

  final String text;
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, // callback ao pressionar o botão
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // cor passada como parâmetro
        shape: ContinuousRectangleBorder(), // retangular
        fixedSize: Size(180, 40), // tamanho fixo, pelo menos por enquanto
      ),
      // texto do botão com sua cor, ambos recebidos como paramêtros
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
    );
  }
}