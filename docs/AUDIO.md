# Áudio e efeitos sonoros

Como citado na documentação de escolhas ([ESCOLHAS.md](./ESCOLHAS.md)),
utilizamos a biblioteca `flame_audio` para a reprodução dos efeitos sonoros.

Sendo requisito para o projeto, é reproduzido um som ao iniciar um nível 
(no caso, quando o usuário chega em um nível), e quando a bola é rebatida pela plataforma
controlada pelo usuário (_paddle_).

Os arquivos utilizados (`paddle_hit.wav` e `start.wav`) foram criados com as ferramentas
__bfxr__ ([www.bfxr.net](https://www.bfxr.net/)) 
e __ChipTone__ ([sfbgames.itch.io/chiptone](https://sfbgames.itch.io/chiptone)),
respectivamente.