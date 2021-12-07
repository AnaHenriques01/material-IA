%---------------------------------------------------------------------------------------------------
% INTELIGÊNCIA ARTIFICIAL - MiEI/LEI/3

%---------------------------------------------------------------------------------------------------
% # Pensamento positivo e negativo (Ficha 9)

%---------------------------------------------------------------------------------------------------
% PROLOG: definicoes iniciais

:- dynamic '-'/1.
:- dynamic mamifero/1.
:- dynamic morcego/1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%PENSAMENTO POSITIVO / VERDADEIRO

voa(X) :-                       % A entidade X voa se:
    ave(X),                     % for uma ave
    nao(excecao(voa(X))).       % e se não for uma das exceções de voar: aves que não voam.
voa(X) :-
    excecao(-voa(X)).           % ou, então, se for uma exceção de não voar: animais que voam, mas que não são aves.

%PENSAMENTO NEGATIVO / FALSO

-voa(tweety).                                                       % Não sabemos se o tweety é uma ave, mas sabemos que não voa.
-voa(X) :- mamifero(X), nao(excecao(-voa(X))).                      % Todos os mamíferos não voam, à exceção do morcego que voa.
-voa(X) :- excecao(voa(X)).                                         % Todos aqueles que sao excecão de voar, neste caso o pinguim e a avestruz, não voam.

excecao(voa(X)) :-
    pinguim(X).
excecao(voa(X)) :-
    avestruz(X).
excecao(-voa(X)) :-
    morcego(X).
	
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).
