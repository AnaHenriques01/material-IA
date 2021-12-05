%---------------------------------------------------------------------------------------------------
% Inteligência Artificial - MiEI/3 LEI/3

% # base de conhecimento
jarros(0,0).
jarros(8,0).
jarros(0,5).
jarros(8,5).
jarros(3,5).
jarros(5,0).

% # estado inicial 
inicial(jarros(0,0)).

% # estado final 
final(jarros(_,4)).
final(jarros(4,_)).

% # transição - operação

transicao(jarros(V1,V2), vazio(1), jarros(0,V2)) :- V1 < 0.
transicao(jarros(V1,V2), vazio(2), jarros(V1,0)) :- V2 < 0.

transicao(jarros(V1,V2), encher(1), jarros(8,V2)) :- V1 < 8.
transicao(jarros(V1,V2), encher(2), jarros(V1,5)) :- V2 < 5.

%Transferir do jarro V1 para encher o jarro V2.
transicao(jarros(V1,V2), encher(1,2), jarros(NV1,NV2)) :-
        V1 > 0,
        NV1 is max(V1 -5 + V2, 0),               % garantir que o resultado ou é 0 ou é superior a 0
        NV1 < V1,
        NV2 is V2 + V1 – NV1.

%Transferir do jarro V2 para encher o jarro V1.
transicao(jarros(V1,V2), encher(2,1), jarros(NV1,NV2)) :-
        V2 > 0,
        NV2 is max(V1 + V2 – 8, 0),              % garantir que o resultado ou é 0 ou é superior a 0
        NV2 < V2,
        NV1 is V1 + V2 – NV2.


%---------------------------------------------------------------------------------------------------

% # RESOLVER EM PROFUNDIDADE (DPS):

resolveProfundidade(Solucao) :-
        incial(InicialEstado),                                         % temos o estado inicial            
        resolveProfundidade(InicialEstado,[IncialEstado],Solucao).     % resolvemos em profundidade recursivamente até chegar ao estado final

%Ele vai descendo na árvore até chegar ao final: final( Estado ) | e depois pára: !
resolveProfundidade(Estado,Historico,[]) :-
        final(Estado),!.

%Se quero ir de um estado para o outro, ou seja, de um nodo para o outro, temos de verificar a adjacência e é isso que o predicado transicao faz.
%Depois temos de verificar se aquele nodo ainda não foi visitado e é, por isso, que verificamos se é um membro do histórico.
%NOTA: As operações, neste contexto, são encher e esvaziar.
resolveProfundidade(Estado,Historico,[Operacao|Solucao]) :-
        transicao(Estado,Operacao,Estado1),
        nao(member(Estado1,Historico)),
        resolveProfundidade( Estado1,[Estado1|Historico],Solucao).

%Todos os caminhos em profundidade
todos(L):- findall((S,C), (resolveProfundidade(S),length(S,C)), Lista).

%Escolhe o melhor caminho em preofundidade - com o menor custo
melhor(S,Custo):-findall((S,C), (resolveProfundidade(S),length(S,C)), Lista), minimo(L,(S,Custo)).

minimo([(P,X)],(P,X)).
minimo([(Px,X)|L],(Py,Y)) :- minimo(L,(Py,Y)), X > Y.
minimo([(Px,X)|L],(Px,X)) :- minimo(L,(Py,Y)), X <= Y.

%---------------------------------------------------------------------------------------------------

% # RESOLVER EM LARGURA (BFS):

%---------------------------------------------------------------------------------------------------

nao(Q) :- Q, !, Fail.
nao(Q).
