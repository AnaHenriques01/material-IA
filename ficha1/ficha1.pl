%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial MIEI /3  LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informação genealógica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado filho: Filho,Pai -> {V,F}

filho(joao, jose).
filho(jose,manuel).
filho(carlos,jose).

filho(nadia,carlos).
filho(carlos,antonio).

filho(manuel,tiago).
filho(tiago,afonso).

filho(filipe,paulo).
filho(maria,paulo).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado pai: Pai,Filho -> {V,F}

pai(P,F) :- filho(F,P).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado avo: Avo,Neto -> {V,F}

avo(A,N) :- filho(X,A), filho(N,X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado irmão: Filho,Filho,Pai -> {V,F}

irmao(F1,F2,P) :- filho(F1,P),filho(F2,P).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado sexo: Pessoa,Sexo -> {V,F}

sexo(joao,masculino).
sexo(jose,masculino).

sexo(maria,feminino).
sexo(joana,feminino).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado neto: Neto,Avo -> {V,F}

neto(N,A) :- avo(A,N).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado descendente: Descendente,Ascendente -> {V,F}

descendente(D,A) :- filho(D,A).                     % caso base
descendente(D,A) :- filho(D,X),descendente(X,A).    % caso recursivo

% NOTA: para fazer a disjunção, basta colocar a outra opção na linha a seguir (ou usar ponto e vírgula), mas com o mesmo predicado.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado grau: Descendente,Ascendente,Grau -> {V,F}

grau(D,A,1) :- filho(D,A).
grau(D,A,G) :- filho(D,X),grau(X,A,N), G is N+1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado avoGrau: Avo,Neto -> {V,F}

avoGrau(A,N) :- grau(N,A,2).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo(X,Y) :- grau(X,Y,3).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado trisavo: Trisavo,Trisneto -> {V,F}

trisavo(X,Y):-grau(X,Y,4).
