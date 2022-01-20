# Inteligência Artificial

No swim-prolog:

- pwd
- cd(‘~/Desktop’).
- [file].

## Matéria:

Em Prolog, predicados com o MESMO nome, mas com o número de argumentos DIFERENTES - aridade diferente - são predicados diferentes.

- Para sinalizar uma conjunção, utiliza-se uma virgula.
- Para sinalizar uma disjunção, utiliza-se um ponto e vírgula ou, então, em linhas diferentes.

Por exemplo:\
tocaGuitarra(miguel):-feliz(miguel).\
tocaGuitarra(miguel):-ouveMusica(miguel).

Têm ambas o mesmo nome de predicado e a mesma aridade — tocaGuitarra(miguel) — mas têm ambas corpos diferentes. Como tal, é uma disjunção ( ou é feliz ou ouve música ).

### CUT

O comando cut permite indicar ao Prolog quais sub-objetivos já satisfeitos não necessitam ser reconsiderados ao se realizar um backtracking. Isto é, ele aborta o processo de backtracking.

O uso do comando cut é importante porque permite que o programa rode mais rápido, sem perder tempo com sub-objetivos que não contribuem para determinar a resposta do objetivo principal e ocupa ainda menos memória.

No caso, X > Y, !. Se X = 3 e Y = 2, então eu não preciso de verificar outros ramos da árvore de prova, porque eu sei que o 3 > 2 e não preciso de ver mais nada.

Exemplo:

O código abaixo faz a consulta ao banco e pára na primeira ocorrência de filho do sexo masculino:\
primogenito(X,Y) :- pai(Y,X),masculino(X),!.


### FAIL

Em lógica, fail significa provar que falha. Ou seja, provar que a verdade é falhar.

gosta(maria,X) :- reptil(X),!,fail.\
gosta(maria,X) :- animal(X).

Neste caso, a maria gosta de qualquer animal, exceto répteis.

A utility predicate meaning something like “not equals”.\
diferente(X,X) :- !,fail.\
diferente(_,_).

Se ambas as variáveis forem iguais, dá falso. Tudo o resto, é verdadeiro.


### NOT

not(G) fails if G succeeds.\
not(G) succeeds if G does not succeed.

gosta(maria,X) :- not(reptil(X)).\
diferente(X,Y) :- not(X=Y).

Imaginenos isto:\
inocente(X) :- ocupacao(X,freira).\
ocupado(X) :- ocupacao(X,ladrao).

> inocente(s_francisco).\
> no.

Isto quer dizer que inocente(s_francisco) não está na base de bases; não quer dizer, no entanto, que ele é culpado.\
Contudo, fazer algo deste género culpado(X) :- not(inocente(X)) também não ajuda.\
Aprenderemos mais para a frente uma forma correta de resolver a situação.

O cat ! impossibilita voltar atrás nas opções. Deste modo, não elimina o sistema de fazer o retrocesso.\
O fail é provocado forçosamente por nós.

solucoes(X, filho(jose,joao), S).                      — sendo X todas as soluções possíveis.


### TESTAR GRAFOS

?- g(G), adjacente(braga,guimaraes,X,Y,G).

Para mostrar mais opções para X, tenho de fazer ⇧.


Quando se trata de pesquisa, primeira explora-se ao nível de largura (ser o nodo a seguir).

					     (0,0)
                                        /            \
                         (8,0)                            (0,5)
                   /       |       \                 /      |      \
		 (0,0)   (8,5)   (3,5)             (0,0)  (8,5)  (5,0)
	     /          \
           (8,0)      (0,5)



- Uma solução para um problema é o caminho do estado inicial para o estado do objetivo.
- A qualidade da solução é medida pela função de custo do caminho e uma solução “ideal” tem o menor custo do caminho entre todas as possíveis soluções.
- O mundo “real” é obviamente mais complexo: o o espaço de estado é um abstração para a solução de problemas.
- Estado (abstrato) = conjunto de estados reais.
- Ação (abstrata) = combinação complexa de ações reais.
- Para garantia de realização, qualquer estado "em Arad" deve chegar a algum estado "em Zerind“.
- Solução (abstrata) = conjunto de caminhos reais que são soluções no mundo real.
- Cada ação abstrata deve ser "mais fácil" do que o problema original.

### Tipos de problemas:

- Ambiente determinístico, totalmente observável — problema do estado único.\
O agente “sabe” exactamente o estado em que estará; a solução é uma sequência.

- Ambiente determinístico, não acessível — problema de múltiplos estados.\
O agente não “sabe” onde está; a solução é uma sequência.\
Se puder ter vários estados, então estamos perante um problema de estado múltiplo.\
Imaginemos que temos um mapa e temos vários lugares para poder chegar a um lugar em específico. Temos de fazer uma matriz de estimativas e ir vendo a estimativa de um lugar para o outro.

- Ambiente não determinístico e/ou parcialmente acessível — problema de contigência.
Percepções fornecem novas informações sobre o estado actual.\
Frequentemente intercalam pesquisa e execução.

- Espaço de estados desconhecido — problema de exploração.


### PESQUISA NÃO INFORMADA

Pesquisa em Largura: primeiro pesquisa em largura e depois vai “descendo”.

Pesquisa em Profundidade: primeiro vai às folhas de cada nodo e depois é que pesquisa “lateralmente”.

——> Estas duas pesquisas são de pesquisa não informada, ou seja, são de pesquisa “forçada”. Elas vão sempre seguir aqueles “caminhos” (largura ou produfindade), independentemente de serem os melhores caminhos OU NÃO.


PESQUISA INFORMADA

A pesquisa informada já não é forçada. Esta segue as circunstâncias que lavam ao melhor caminho em termos de peso.

A gulosa (método de pesquisa informada) vai escolhendo, passo a passo, o caminho mais curto. Ou seja, entre duas opções escolhe o mais curto. No entanto, isso não quer dizer que, no final, o output seja o caminho mais curto.

												  *
											5 /   	        \ 10
    											 *               *
              								             5 /   	         / 2
									   * ——— * ——— ★
										 3	     3

Neste caso, para chegar a ★, a gulosa vai escolher, entre o 5 e o 10, o 5 porque 5 é menor do que 10. E depois seguirá o caminho 5-5-3 porque é o único caminho que leva à ★. No entanto, nós conseguimos analisar que o melhor caminho (menor custo) para chegar à ★ é 10-2.

A à estrela (outro método de pesquisa informada) já vai acumulando passo a passo e, no final, escolher o melhor caminho (de menor custo).


### INVARIANTES

Evolução não é só inserir conhecimento. Também é caracterizada por passar do impreciso/desconhecido para verdadeiro.


### INFORMAÇÃO POSITIVA E NEGATIVA

Informação positiva - q(X).\
Informação negativa - (-q(X)).\
Tudo aquilo que não conseguimos provar como verdadeiro ou falso é desconhecido.

- atravessar <- não comboio, ou seja, -comboio.                   Negação forte

                é diferente de

- atravessar <- nao(comboio).                                     Negação por falha na prova

A primeira negação é muito mais forte porque uma coisa é dizer “posso atravessar se tiver evidência de que o comboio não está a atravessar” e outra coisa, muito mais forte, é dizer “posso atravessar porque não há nenhum comboio”. Negação por falha na prova: não consigo encontrar nenhuma prova de que é verdade, então ASSUMO que é falso.

O nao(comboio) é não há evidências que há um comboio e, por isso, assumo que é falso.\
O -comboio não é para assumir nada, não há, DE FACTO, nenhum comboio e porque isso é verdadeiro que NÃO há.

Portanto, -q(X) é diferente de nao(q(X)).


### IMPORTANTE PARA O TESTE

- Valores nulos do tipo incerto: 
Exemplo\
Eu ganho mais do que 1000€. Mas quanto?\
O domínio é demasiado grande para eu saber o valor.

- Valores nulos do tipo interdito:
Exemplo\
Estás proibido de saber quanto eu ganho.\
O domínio é demasiado restrito para eu saber o valor.

- Valores nulos do tipo impreciso:\
Exemplo\
Eu ganho entre 950€ a 1050€.

