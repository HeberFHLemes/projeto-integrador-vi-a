import 'brick_color_pattern.dart';
import 'brick_size.dart';

/// Opções (configurações) do jogo que selecionadas pelo usuário,
/// sendo o tamanho dos blocos e o padrão de cores da parede de blocos.
class GameOptions {
  BrickSize brickSize = BrickSize.medium;
  BrickColorPattern brickColorPattern = BrickColorPattern.classico;

  GameOptions({
    this.brickSize = BrickSize.medium,
    this.brickColorPattern = BrickColorPattern.classico,
  });
}