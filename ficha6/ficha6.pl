%---------------------------------------------------------------------------------------------------
% Inteligência Artificial - MiEI/3 LEI/3

% # Pesquisa Não Informada e Informada (Ficha 6)

%Usando a estratégia “primeiro em profundidade com cálculo de custo”, identifique o melhor caminho possível

%Todas as adjacências deste grafo:
move( a,b,2 ).
move( b,a,2 ).
move( a,s,2 ).
move( s,a,2 ).
move( s,e,2 ).
move( e,s,2 ).
move( e,f,5 ).
move( f,e,5 ).
move( f,g,2 ).
move( g,f,2 ).
move( g,t,2 ).
move( t,g,2 ).
move( t,d,3 ).
move( d,t,3 ).
move( d,c,3 ).
move( c,d,3 ).
move( c,b,2 ).
move( b,c,2 ).

%Todas as estimativas dos nodos:
estima( a,5 ).
estima( b,4 ).
estima( c,4 ).
estima( d,3 ).
estima( g,2 ).
estima( f,4 ).
estima( e,7 ).
estima( s,10 ).

%Nodo final:
goal(t).


%---------------------------------------------------------------------------------------------------

%Usando a estratégia “primeiro em profundidade com cálculo de custo”, identifique o melhor caminho possível.

%Nodo – de onde eu parto.
%[Nodo] – começa a guardar o caminho por onde já passou

resolvepp(Nodo,[Nodo|Caminho],Custo) :-
	profundidade(Nodo,[Nodo],Caminho,Custo).

profundidade(Nodo,_,[],0) :-                  % se não há caminho (lista []), então já estamos no nodo final
		find(Nodo), !.
profundidade(Nodo,Historico,[Proximo|Caminho],Custo) :-                 %[Proximo|Caminho] – indica que continua a ver os próximos nodos do caminho.
		move(Nodo,Proximo,Custo1),										% Nodo e Proximo têm de ser adjacentes
		nao(member(Proximo,Historico)),								    % Proximo não ter sido antes visitado
		profundidade(Proximo,[Proximo|Historico],Caminho,Custo2),		% Aplicar recursivamente a partir do Proximo
		Custo is Custo1 + Custo2.

%---------------------------------------------------------------------------------------------------

%Resolva este problema utilizando a estratégia de pesquisa informada GULOSA!!!!!!!!!

resgulosa(Nodo,Caminho/Custo) :-
		estima(Nodo, Estima),
		agulosa([[Nodo]/0/Estima], InversoCaminho/Custo/_),             % usamos _ porque não importa a estima
		Inverso(InversoCaminho, Caminho).

% ------- Auxiliar da resgulosa -------

%Caminhos (uma lista) são os caminhos expandidos porque um nó pode ter 4 ligações. Dessas 4 ligações, temos de escolher a mais curta.
%Caminho é o caminho final.

%Caso base.
agulosa(Caminhos, Caminho) :-
		obtem_melhor_g(Caminhos, Caminho),                    % escolher o melhor caminho entre as possibilidades (-- Caminhos) e colocá-lo em Caminho.
		Caminho = [Nodo]/_/_, goal(N). 							% o caminho será este se chegarmos ao nodo final (goal(N)). este é o ponto de paragem.
																% como não interessa para o ponto de paragem saber o custo nem a estima, usamos /_/_
agulosa( Caminhos, Solucao ) :-
		obtem_melhor_g(Caminhos, MelhorCaminho),
		seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
		expande_gulosa(MelhorCaminho, ExpCaminhos),
		append(OutrosCaminhos, ExpCaminhos, NovosCaminhos),
		agulosa(NovosCaminhos, Solucao).

% ------- Auxiliares da agulosa -------

%Lista de um caminho.
obtem_melhor_g([Caminho], Caminho) :- !          % quem está à cabeça da lista é o melhor caminho, então já o descobrimos. daí o cut, não precisamos de continuar a procurar.

%Agora vamos ter uma lista de caminhos.
obtem_melhor_g([(Caminho1/Custo1/Estima1),(Caminho2/Custo2/Estima2)|Caminhos], MelhorCaminho) :-
		Estima1 =< Estima2, !,                     % se isto acontecer, não fazer backtracking às alternativas desta condição.
		obtem_melhor_g([(Caminho1/Custo1/Estima1)|Caminhos], MelhorCaminho).

obtem_melhor_g([_|Caminhos], MelhorCaminho) :-
		obtem_melhor_g(Caminhos, MelhorCaminho).


%Encontra todos os NovoCaminho que tenham uma relação de adjacência entre o NovoCaminho o caminho.
expande_gulosa(Caminho,ExpCaminhos) :- findall(NovoCaminho, adj( Caminho, NovoCaminho ), ExpCaminho).


adj( [Nodo|Caminho]/Custo1/Estima1, [ProxNodo|Caminho]/NovoCusto2/Estima2 ) :-
		move(Nodo,ProxNodo,ProxCusto),
		\+member(ProxNodo, Caminho),								% o nodo ainda não tinha sido antes visitado
		NovoCusto is Custo1 + ProxCusto,							% NovoCusto é o custo acumulado dos dois nodos
		estima(ProxNodo, Estima2).									% garantir que o proximo nodo também tem uma estima


%Seleciona o elemento que estiver à cabeça.
seleciona(E,[E|XS],XS).
seleciona(E,[X|XS],[X|]YS]) :- seleciona(E,XS,YS).

%---------------------------------------------------------------------------------------------------

%Resolva este problema utilizando a estratégia de pesquisa informada A*!!!!!!!!!

%No A*, o que mudaria, tendo em conta a gulosa, seria apenas o predicado obtem_melhor_g (na linha Estima1 =< Estima2) porque tem de se calcular o valor acumulado.

res_aestrela(Nodo, Caminho/Custo) :-
	estima(Nodo, Estima),
	aestrela([[Nodo]/0/Estima], InvCaminho/Custo/_),
	inverso(InvCaminho, Caminho).

% ------- Auxiliar da res_aestrela -------

aestrela(Caminhos, Caminho) :-
	obtem_melhor(Caminhos, Caminho),
	Caminho = [Nodo|_]/_/_,
	goal(Nodo).

aestrela(Caminhos, SolucaoCaminho) :-
	obtem_melhor(Caminhos, MelhorCaminho),
	seleciona(MelhorCaminho, Caminhos, OutrosCaminhos),
	expande_aestrela(MelhorCaminho, ExpCaminhos),
	append(OutrosCaminhos, ExpCaminhos, NovoCaminhos),
    aestrela(NovoCaminhos, SolucaoCaminho).	

% ------- Auxiliar da aestrela -------

obtem_melhor([Caminho], Caminho) :- !.
obtem_melhor([Caminho1/Custo1/Est1,_/Custo2/Est2|Caminhos], MelhorCaminho) :-
	Custo1 + Est1 =< Custo2 + Est2, !,
	obtem_melhor([Caminho1/Custo1/Est1|Caminhos], MelhorCaminho). 
obtem_melhor([_|Caminhos], MelhorCaminho) :- 
	obtem_melhor(Caminhos, MelhorCaminho).

expande_aestrela(Caminho, ExpCaminhos) :-
	findall(NovoCaminho, adjacente2(Caminho,NovoCaminho), ExpCaminhos).

%---------------------------------------------------------------------------------------------------
% Extensao do meta-predicado nao: Questao -> {V,F}

nao( Questao ) :-
    Questao, !, fail.
nao( Questao ).

membro(X, [X|_]).
membro(X, [_|Xs]):-
	membro(X, Xs).
