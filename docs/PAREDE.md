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
