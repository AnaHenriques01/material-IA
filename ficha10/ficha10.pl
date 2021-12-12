%---------------------------------------------------------------------------------------------------
% # Linguagem em lógica EXTENDIDA (Ficha 10)

%Definir o verdadeiro, o falso e o desconhecido.
%Isto não existe em PROLOG, por isso, temos de ser nós a extender.

%Para lidar com o desconhecido, tenho de definir um sistema de inferência:
si(Q,verdadeiro) :- Q.
si(Q,falso) :- -Q.
si(Q,desconhecido) :- nao(Q), nao(-Q).              % ou seja, nem é verdadeiro, nem é falso.

%---------------------------------------------------------------------------------------------------

excecao(jogo(Id,Arbitro,Ajudas)) :-
    jogo(Id,Arbitro,xpto0123).

%---------------------------------------
%alinea i)

jogo(1,aa,500).

%---------------------------------------
%alinea ii)

jogo(2,bb,xpto0123).

%---------------------------------------
%alinea iii)

%Para a situação dos invariantes, que diziam sempre que não pode haver jogos com o mesmo id, teríamos de aplicar estes invariantes
%a todos os termos, MAS não às exceções. As exceções já podem ter ids repetidos.

excecao(jogo(3,cc,500)).
excecao(jogo(3,cc,2500)).

-jogo(3,Arbito,Ajudas) :-             %Nao há jogo se:
    nao(jogo(3,Arbito,Ajudas)),
    nao(excecao(jogo(3,Arbito,Ajudas))).

%---------------------------------------
%alinea iv)

excecao(jogo(4,dd,Ajudas)) :-
    Ajudas >= 250, Ajudas <= 750.

%---------------------------------------
%alinea v)

jogo(5,ee,xpto765)).

excecao(jogo(Jogo,Arbitro,Ajudas)) :-
       jogo(Jogo,Arbitro,xpto765).

nulo(xpto765).

+jogo(J,A,C) :: (
    findall(Ajudas,(jogo(5,ee,Ajudas),not(nulo(Ajudas)))),S),
    length(S,N),
    N==0
).

%---------------------------------------
%alinea vi)

jogo(6,ff,250).
excecao(jogo(6,ff,V)) :- V>=5000.

%---------------------------------------
%alinea vii)

-jogo(7,gg,2500).

jogo(7,gg,xpto4567).
excecao(jogo(Jogo,Arbitro,Ajudas)):-
    jogo(Jogo,Arbitro,xpto4567).

%---------------------------------------
%alinea viii)

excecao(jogo(8,hh,Ajudas)):-
    Ajudas >= 1000*0.75, Ajudas =< 1000*1.25.

%---------------------------------------
%alinea ix)

excecao(jogo(9,ii,Ajudas)) :-
    Ajudas >= 3000*0.9, Ajudas =< 3000*1.1.



% # Invariantes

+jogo(Id,_,_) :: (
    findall(Arbitro, jogo(Id,Arbitro,_), Lista),
    length(Lista,1)
).

+jogo(_,Arbitro,_) :: (
    findall(Id, jogo(Id,Arbitro,_), Lista),
    length(Lista,N),
    N =< 3
).
