%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :- X \= Y,pertence( X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [X|L],N ) :- comprimento( L,N1 ), N is N1+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado quantos: Lista,Comprimento -> {V,F}

quantos( [],0 ).    
quantos( [X|L],N ) :- pertence( X,L ),quantos( L,N ).               
quantos( [X|L],N ) :- nao(pertence(X,L)),quantos( L,N1 ), N is N1+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}

apaga1( _,[],[] ).
apaga1( X,[X|L],L ).
apaga1( X,[H|T],R ) :- X \= H, apaga1( X,T,R1 ).
% apaga1( X,[H|T],[H,R] ) :- X \= H, apaga1(X,T,R).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}

apagaT(_,[],[]).
apagaT(X,[X|T],R) :- apaga1(X,[X|T],R1), apagaT(X,R1,R2).
apagaT(X,[Z|T],R) :- X \= Z, apagaT(X,T,R1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}

adiciona( X,[],[X] ).
adiciona( X,L,[X|L] ) :- nao( pertence(X,L) ).
adiciona( X,L,L ) :- pertence( X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}
% Não funcional
concatena([],L1,L1).
concatena([X|Tail],L2,[X|Tail1]):-
    concatena(Tail,L2,Tail1).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}

inverte( [],[] ).
inverte( [_|[]],[_|[]] ).
inverte( [X|L],R ) :- inverte( L,R1 ), adiciona( X,R2,R ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

sublista( [],_ ).
sublista( [H|T],L ) :- pertence( H,L ), sublista( T,L ).

sublist([],[]).
sublist([First|Rest],[First|Sub]):-sublist(Rest,Sub).
sublist([_|Rest],Sub):-sublist(Rest,Sub).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :- Questao, !, fail.
nao( Questao ).

