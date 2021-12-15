%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% SIST. REPR. CONHECIMENTO E RACIOCINIO - MiEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Programação em lógica 
% Grafos (Ficha 9)

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Diferentes representações de grafos
%
%lista de adjacências: [n(b,[c,g,h]), n(c,[b,d,f,h]), n(d,[c,f]), ...]
%
%termo-grafo: grafo([b,c,d,f,g,h,k],[e(b,c),e(b,g),e(b,h), ...]) or
%            digrafo([r,s,t,u],[a(r,s),a(r,t),a(s,t), ...])
%
%clausula-aresta: aresta(a,b)


%---------------------------------

g( grafo([madrid, cordoba, braga, guimaraes, vilareal, viseu, lamego, coimbra, guarda],
  [aresta(madrid, corboda, a4, 400),
   aresta(braga, guimaraes,a11, 25),
   aresta(braga, vilareal, a11, 107),
   aresta(guimaraes, viseu, a24, 174),
   aresta(vilareal, lamego, a24, 37),
   aresta(viseu, lamego,a24, 61),
   aresta(viseu, coimbra, a25, 119),
   aresta(viseu,guarda, a25, 75)]
 )).

%--------------------------------- 
%alinea 1)

%Escreva um predicado adjacente(X,Y,G) que verifica se os nós X e Y são adjacentes no grafo G.

adjacente(X,Y,K,E, grafo(_,Es)) :- member(aresta(X,Y,K,E),Es).
adjacente(X,Y,K,E, grafo(_,Es)) :- member(aresta(Y,X,K,E),Es).

% TESTAR: ?- g(G), adjacente(braga,guimaraes,X,Y,G).
% O prolog vai mostrar qual é o resultado válido para aquela expressão.

%--------------------------------- 
%alinea 2)

%Escreva um predicado caminho(G,A,B,P) para encontrar um caminho acíclico P do nó A para o nó B no grafo G.

caminho(G,A,B,P) :- caminho(G,A,B,[B],P).

caminho(Grafo,A,A,[A|Caminho],[A|Caminho]).
caminho(Grafo,A,B,Historico,Caminho) :-           
    adjacente(C,B,_,_,Grafo),                     % C é o nodo anterior ao nodo B (daí ser adjacente).
    nao(membro(C,Historico)),                     % C não pode ter sido anteriormente visitado, ou seja, esta tem de ser a primeira e única visita ao nodo C.
    caminho(Grafo,A,C,[C|Historico],Caminho).     % aplicar recursivamente o predicado de modo a chegarmos do nodo A ao nodo C e, agora, tem de se adicionar C à lista dos nodos visitados.

%---------------------------------
%alinea 3)

%Escreva um predicado ciclo(G,A,P) para encontrar um caminho fechado P, que começa e acabe no nó A, no grafo G.

ciclo( G,A,P ) :- 
      adjacente( A,B,_,_,G ),                     % visitar o nodo B que está a seguir ao A (daí A ter de ser adjacente ao nodo B).
      caminho( G,B,A,P ).                         % descobrir o caminho desde o ponto B ao ponto A.
      
%--------------------------------- 
%alinea 4)

%Escreva um predicado caminhoK(G,A,B,P, Km, Es) para encontrar um caminho acíclico P do nó A para o nó B no grafo G,
%devolvendo, ainda, os quilómetros (Km) e as estradas percorridas (Es).

caminhoK(G,A,B,P,Km,Es) :-
      caminho1K(G,A,[B],P,Km,Es).

caminho1K(_,A,[A|P1],[A|P1],0, []).
caminho1K(G,A,[Y|P1],P,K1,[E|Es]) :- 
    adjacente(X,Y,E,Ki,G),
    nao(membro(X,[Y|P1])),
    caminho1K(G,A,[X,Y|P1],P,K,Es),
    K1 is K + Ki.

%--------------------------------- 
%alinea 5)

%Escreva um predicado cicloK(G,A,P, Km, Es) para encontrar um caminho fechado P, que começa e acabe no nó A, no grafo G,
%devolvendo, ainda, os quilómetros (Km) e as estradas percorridas (Es).

cicloK( G,A,P,Km,Es ) :-
      adjacente( A,B,Km1,Es1,G ),
      caminhoK( G,B,A,P,Km2,Es2),
      Km is Km1 + Km2,
      Es is [Es1|Es2].
  
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).
