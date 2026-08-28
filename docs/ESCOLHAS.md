# Escolha das tecnologias e explicações sobre o desenvolvimento e entrega

## Tecnologias
Utilizaremos o framework **Flutter** (que utiliza a linguagem de programação Dart)
para o desenvolvimento do aplicativo para dispositivos móveis.

Para as funcionalidades relativas ao jogo em si, utilizaremos a _game engine_ **Flame**, que fornece
recursos que facilitam sua implementação, como o controle do loop do jogo e a detecção de colisões.

Além destas duas tecnologias principais, também utilizaremos algumas bibliotecas, sendo as principais:
`flutter_animate` para animações e efeitos, `google_fonts` para as fontes utilizadas
e `flame_audio` para manipular o áudio da aplicação.

## Ambiente de desenvolvimento

Como ambiente de desenvolvimento, utilizaremos principalmente o Android Studio com o _plugin_ específico
para desenvolvimento em Flutter. Cada integrante poderá, no entanto, optar por outra IDE de sua preferência,
como o VS Code com a extensão do Flutter.

## Geração do arquivo APK

O arquivo APK será gerado executando, em linha de comando, `flutter build apk`.

> Esse comando gera o arquivo em modo `release`, mas é possível adicionar a flag `--split-per-abi` para gerar diferentes arquivos APKs separados por arquitetura, reduzindo o tamanho do arquivo entregue (o dispositivo instala apenas o APK correspondente à sua própria arquitetura).

> Como, por ora, não pretendemos disponibilizar o aplicativo em lojas, não faremos a assinatura dos arquivos gerados.

Após a execução do comando ser concluída com sucesso, o APK estará disponível, a partir da pasta raiz do
projeto, em: `build/app/outputs/flutter-apk/`
