# Bowling Game

## EN

Write an API for a bowling game
You have the freedom to define the architecture of the API and how its endpoints will look
like.
Main Requirements
The API should be written using Ruby on Rails. In addition, it should provide the following
actions:
● Start a new bowling game.
● Input the number of pins knocked down by each ball.
● Output the current game score (which consists of the score for each frame and total
score).
Imagine that this API will be used by a bowling house. On the screen the user starts the
game. Then after each throw, the machine counts how many pins were dropped and calls
the API, sending this information. In the meantime, the screen is constantly (for example:
every 2 seconds) querying the API for the game score and displays it. You can consider all
games to be single player, so there’s no need for a “player” concept.
Logic details
● Bowling is played by throwing a ball down a narrow alley towards ten wooden pins. The
objective is to knock down as many pins as possible per throw.
● The game is played in ten frames. At the beginning of each frame, all ten pins are set up.
The player then gets two tries to knock them all down.
● If the player knocks all the pins down on the first try, it is called a “strike” and the frame
ends.
● If the player fails to knock down all the pins with his first ball but succeeds with the second
ball, it is called a “spare”.
● After the second ball of the frame, the frame ends even if there are pins still standing.
● A strike frame is scored by adding ten plus the number of pins knocked down by the next
two balls, to the score of the previous frame.
● A spare frame is scored by adding ten plus the number of pins knocked down by the next
ball, to the score of the previous frame.
● Otherwise, a frame is scored by adding the number of pins knocked down by the two balls
in the frame to the score of the previous frame.
● If a strike is thrown in the tenth frame, then the player may throw two more balls to
complete the score of the strike.
● Likewise, if a spare is thrown in the tenth frame, the player may throw one more ball to
complete the score of the spare.
● Therefore, the tenth frame may have three balls instead of two.
For more information, please see https://en.wikipedia.org/wiki/Ten-pin_bowling

## PT-BR

Escreva uma API para um jogo de boliche
Você tem a liberdade de definir a arquitetura da API e a aparência de seus enpoints serão.

Principais Requisitos

A API deve ser escrita usando Ruby on Rails. Além disso, deve fornecer as seguintes
ações:

● Inicie um novo jogo de boliche.

● Insira o número de pinos derrubados por cada bola.

● Gerar a pontuação atual do jogo (que consiste na pontuação de cada quadro e no total
Ponto).

Imagine que essa API será usada por uma casa de boliche. Na tela, o usuário inicia os
jogos.

 Depois de cada lançamento, a máquina conta quantos pinos foram derrubados e chama
a API, enviando essas informações. Enquanto isso, a tela é constantemente atualizada (por exemplo: a cada 2 segundos) consultando a API para obter a pontuação do jogo e a exibe. 

Você pode considerar todos os jogos para ter apenas um jogador, por isso não há necessidade de um conceito de "jogadores".

Detalhes da lógica

● O boliche é jogado jogando uma bola em um beco estreito em direção a dez pinos de madeira. O objetivo é derrubar o maior número possível de pinos por lance.

● O jogo é jogado em dez quadros. No início de cada quadro, todos os dez pinos estão configurados. O jogador então recebe duas tentativas para derrubá-los todos.

● Se o jogador bater todos os pinos na primeira tentativa, isso será chamado de "strike" e o quadro termina.

● Se o jogador não conseguir derrubar todos os pinos com sua primeira bola, mas conseguir com a segunda bola, é chamado de "spare".

● Após a segunda tentativa do quadro, o quadro termina mesmo se ainda houver pinos em pé.

● Um quadro de "strike" é pontuado adicionando dez mais o número de pinos derrubados pelas próxima duas bolas, para a pontuação do quadro anterior.
● Um quadro "spare" é pontuado adicionando dez mais o número de pinos derrubados pela próxima bola, para a pontuação do quadro anterior.
● Caso contrário, um quadro é pontuado adicionando o número de pinos derrubados pelas duas bolas no quadro para a pontuação do quadro anterior.
● Se acontecer um strike no décimo quadro, o jogador poderá lançar mais duas bolas para completar a pontuação do strike.
● Da mesma forma, se acontecer um "spare" no décimo quadro, o jogador poderá jogar mais uma bola para complete a pontuação do "spare".
● Portanto, o décimo quadro pode ter três bolas em vez de duas.
Para mais informações, consulte https://en.wikipedia.org/wiki/Ten-pin_bowling

