%---------------------------------------------------------------------------------------------------
% Inteligência Artificial - MiEI/LEI/3

%---------------------------------------------------------------------------------------------------
% # Invariantes (Ficha 8)

%---------------------------------------------------------------------------------------------------
%Definicoes iniciais

:- op( 900,xfy,'::' ).
:- dynamic filho/2.
:- dynamic pai/2.

%---------------------------------------------------------------------------------------------------

filho(joao,jose).
filho(jose,manuel).
filho(carlos,jose).

pai(P,F) :- filho(F,P).

avo(A,N) :- filho(X,A), filho(N,X).

descendente(D,A,1) :- filho(D,A).
descendente(D,A,G) :- filho(D,X),grau(X,A,N), G is N+1.

%---------------------------------------------------------------------------------------------------
%alinea i)

% Não pode existir mais do que uma ocorrência da mesma evidência na relação filho/2.

% # Invariante Estrutural: não permitir a inserção de conhecimento repetido
+filho(F,P) :: (
    findall((F,P),filho(F,P),S),
    length(S,N), 
    N == 1
).

%---------------------------------------------------------------------------------------------------
%alinea ii)

% Não pode existir mais do que uma ocorrência da mesma evidência na relação pai/2.

% # Invariante Estrutural: não permitir a inserção de conhecimento repetido
+pai(P,F) :: (
    findall((P,F),pai(P,F),S),
    length(S,N),
    N == 1
).

%---------------------------------------------------------------------------------------------------
%alinea iii)

% Não pode existir mais do que uma ocorrência da mesma evidência na relação avô/2.

% # Invariante Estrutural: não permitir a inserção de conhecimento repetido
+neto(N,A) :: (
    findall((N,A),avo(A,N),S),
    length(S,N),
    N == 1
).

%---------------------------------------------------------------------------------------------------
%alinea iv)

% Não pode existir mais do que uma ocorrência da mesma evidência na relação neto/2.

% # Invariante Estrutural: não permitir a inserção de conhecimento repetido
+avo(A,N) :: (
    findall((A,N),avo(A,N),S),
    length(S,N),
    N == 1
).

%---------------------------------------------------------------------------------------------------
%alinea v)

% Não pode existir mais do que uma ocorrência da mesma evidência na relação descendente/3.

% # Invariante Estrutural: não permitir a inserção de conhecimento repetido
+descendente(D,A,_) :: (
    findall((D,A),descendente(D,A,_),S),
    length(S,N),
    N == 1
).

%---------------------------------------------------------------------------------------------------
%alinea vi)

% Não podem existir mais do que 2 progenitores para um dado indivíduo, na relação filho/2.

% # Invariante Referencial: nao admitir mais do que 2 progenitores para um mesmo individuo
+filho(F,P) :: (
    findall((Ps),(filho(F,Ps)),S),
    length(S,N),
    N =< 2
).

%---------------------------------------------------------------------------------------------------
%alinea vii)

%  Não podem existir mais do que 2 progenitores para um dado indivíduo, na relação pai/2.

% # Invariante Referencial: nao admitir mais do que 2 progenitores para um mesmo individuo
+pai(P,F) :: (
    findall((Ps),(pai(Ps,F)),S),
    length(S,N),
    N =< 2
).

%---------------------------------------------------------------------------------------------------
%alinea viii)

% Não podem existir mais do que 4 indivíduos identificados como avô na relação neto/2.

% # Invariante Referencial: nao admitir mais do que 4 avós para um mesmo individuo
+neto(N,A) :: (
    findall((As),(neto(N,As)),S),
    length(S,N),
    N =< 4
).

%---------------------------------------------------------------------------------------------------
%alinea ix)

% Não podem existir mais do que 4 indivíduos identificados como avô na relação avo/2.

% # Invariante Referencial: nao admitir mais do que 4 avós progenitores para um mesmo individuo
+neto(A,N) :: (
    findall((As),(avo(As,N)),S),
    length(S,N),
    N =< 4
).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão dos predicados que permitem a evolução e a involução do conhecimento

evolucao(Termo) :-
    findall(Invariantes,+Termo::Invariantes,Lista),
    insercao(Termo),
    teste(Lista).

insercao(Termo) :-
    assert(Termo).
insercao(Termo) :-
    retract(Termo),!,fail.

teste([]).
teste([R|LR]) :-
    R, teste(LR).
