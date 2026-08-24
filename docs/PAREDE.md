# Métodos de construção da parede de blocos

## Cálculo das medidas

Para a construção da parede de blocos na tela do usuário, iremos primeiro identificar qual é o tamanho dos blocos selecionado (pelo usuário ou o padrão), sendo as opções: "Pequeno", "Médio" e "Grande", definidas em um `enum`.

```dart
enum BrickSize { small, medium, large }
```

Para evitar definirmos valores fixos para cada tamanho de bloco, definimos apenas um valor base, e então multiplicamos por um valor para cada tamanho (para o tamanho pequeno, por exemplo, multiplicamos por 0.85, que seria 85% deste tamanho "base"). Isto para facilitar a alteração das medidas dos blocos em uma possível refatoração ou adição de diferentes tamanhos, ou ainda a possibilidade do usuário escolher livremente o tamanho.

Com base no tamanho selecionado e na largura máxima da tela permitida para a tela de jogo, iremos então calcular as medidas (largura e altura) dos blocos e dos espaçamentos (vertical e horizontal) entre os blocos e entre um bloco e o limite da tela. E, com base nestas medidas, definirmos quantos blocos (colunas) poderão haver para cada linha.

### Valores base e constantes para o cálculo das medidas
Utilizaremos um valor base para a largura dos blocos (`brickWidth`), e para o espaço (mínimo) reservado para o espaçamento (`minGutter`). Além disso, sempre construiremos a parede de blocos com 5 linhas.

### Largura dos blocos
Definiremos a largura dos blocos como o resultado da multiplicação de um valor base para as larguras por um valor que representa uma porcentagem.
```dart
static double _brickFactors(BrickSize brickSize) {
  return switch (brickSize) {
    BrickSize.small => 0.85, // 85%
    BrickSize.medium => 1.0, // 100%
    BrickSize.large => 1.25 // 125%
  };
}
```

```dart
final factor = _brickFactors(brickSize);
brickWidth = baseBrickWidth * factor;
```

### Altura dos blocos
Os blocos terão como altura a medida da metade da largura deles.

### Número de colunas
Para o número de colunas (isto é, número de blocos ou espaços do tamanho de blocos) por linha, buscaremos o maior número de colunas que conseguimos encaixar na largura permitida, ainda reservando um espaçamento mínimo.

Para isso, partimos da inequação:

`maxWidth >= columns * brickWidth + minGutter * (columns + 1)`

Que, pode ser escrita também como:

`columns * (brickWidth + minGutter) + minGutter <= maxWidth`

E, para encontrar o número de colunas:

`columns <= (maxWidth - minGutter) / (brickWidth + minGutter)`

Com isto, utilizamos a função `floor()` para obter o maior número inteiro que satisfaça tal condição.

```dart
columns = ((maxWidth - minGutter) / (brickWidth + minGutter)).floor();
```

### Espaçamentos horizontal e vertical
Encontramos o tamanho do espaçamento horizontal ao dividir a diferença entre a largura da tela e o espaço ocupado pelos blocos pelo número de espaçamentos:
```dart
horizontalGutter = (maxWidth - columns * brickWidth) / (columns + 1);
```

E, para o vertical, usamos 75% do tamanho do horizontal:
```dart
verticalGutter = horizontalGutter * 0.75;
```

---

## Construção da parede

Obtendo as medidas necessárias, incluindo o número de colunas por linha (isto é, espaços onde haverão blocos ou espaços do tamanho de blocos), construiremos a parede de blocos do nível com base nesse número de linhas (por enquanto, sempre 5) e colunas.

Para essa construção, iremos gerar a metade inicial das colunas de cada linha de forma aleatória, e então espelhar na metade final da linha, criando um aspecto simétrico para a parede de blocos. Caso haja um número ímpar de colunas, construímos as colunas do meio de forma independente, também aleatoriamente. Isto se o nível em que o usuário se encontra não for o primeiro, pois este possuirá sempre a parede completa.

Esse _layout_ será representado por uma matriz de booleanos. Em Dart, representada por `List<List<bool>>`.

Com base nesse _layout_ construído, iremos instanciar os objetos que representam os blocos (`Brick`), já com suas propriedades definidas e calculadas, incluindo a posição em que estará (com base na linha e coluna que representa e em suas medidas), e adicionar no conjunto de blocos que representam a parede, em Dart, representado por `List<Brick>`.

```dart
// Na classe responsável por gerar a parede de blocos:

/// Método estático responsável por construir a parede de blocos 
/// (instancia os objetos que representam os blocos),
/// delegando o cálculo das medidas dos blocos para a classe citada anteriormente
/// e a geração do layout ao método estático citado a seguir.
static List<Brick> generateLevel({
  required int level,
  required double maxWidth,
  required BrickSize brickSize,
  required BrickColorPattern colorPattern,
}) {
  // ...
}

/// Método estático que gera o layout da parede, com aleatoriedade.
static List<List<bool>> createRandomizedMap(
  int rows,
  int cols,
  math.Random random,
) {
  final map = <List<bool>>[];

  final halfCols = cols ~/ 2;

  // se tiver número ímpar de colunas
  final hasCenter = cols % 2 != 0;

  for (int r = 0; r < rows; r++) {
    final row = List.filled(cols, false);

    // Quantidade de pares que serão preenchidos
    final numPairs = random.nextInt(halfCols + 1);

    int placed = 0;

    while (placed < numPairs) {
      final idx = random.nextInt(halfCols);

      if (row[idx]) continue;

      // Lado esquerdo
      row[idx] = true;

      // Lado direito (espelhado)
      row[cols - 1 - idx] = true;

      placed++;
    }

    // Se houver uma coluna central, ela é "independente".
    if (hasCenter) {
      final center = halfCols;

      row[center] = random.nextBool();
    }

    map.add(row);
  }
  return map;
}

```

Então, com o conjunto dos blocos (`List<Brick>`), poderemos armazenar isto em uma variável, na classe responsável pelo jogo em si, para adicionar à tela do usuário e permitir reiniciar o mesmo nível quando necessário.

As cores de cada bloco serão definidas com base no padrão de cores selecionado, sendo atribuída aleatoriamente uma das cores deste padrão, armazenadas em uma constante do tipo `Map<BrickColorPattern, List<Color>>`.

