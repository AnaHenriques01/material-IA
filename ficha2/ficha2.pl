%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial - MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operações aritméticas.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado soma: X,Y,Soma -> {V,F}

soma( X,Y,Soma ) :- Soma is X + Y.

% is ilustra qual é o significado da variável Soma.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado soma de 3 vetores: X,Y,Z,Soma3 -> {V,F}

soma3( X,Y,Z,Soma3 ) :- Soma3 is X + Y + Z.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado operação aritmética: X,Y,Operador,Conta -> {V,F}

operacao(X,Y,+,Op) :- Op is X+Y.
operacao(X,Y,-,Op) :- Op is X-Y.
operacao(X,Y,*,Op) :- Op is X*Y.
operacao(X,Y,:,Op) :- Y \= 0, Op is X/Y.              % \= é o mesmo que !=

% NOTA: um símbolo não é uma variável. Se preferissemos escrever adicao em vez de +, teriamos de escrever em letra minuscula para o prolog não reconhecer adicao como uma varíavel.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado maximo: X,Y,Maximo -> {V,F}

%NOTA: Em Prolog, predicados com o MESMO nome, mas com o número de argumentos DIFERENTES, são predicados diferentes.

max( X,Y,Maximo ):- Maximo is max( X,Y ).        % max é um predicado já definido

% OU

maior1( X,Y,X ) :- X > Y.
maior1( X,Y,Y ) :- Y >= X.

% OU

maior2( X,Y,Max ) :- X > Y, Max is X.
maior2( X,Y,Max ) :- Y >= X, Max is Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado maximo entre 3 valores: X,Y,Z,Maximo -> {V,F}

max3( X,Y,Z,Maximo ):- Maximo is max( X, max(Y,Z) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado minimo: X,Y,Minimo -> {V,F}

min( X,Y,Minimo ) :- Minimo is min( X,Y ).

% OU 

menor1( X,Y,X ) :- X < Y.
menor1( X,Y,Y ) :- Y <= X.

% OU

menor2( X,Y,Min ) :- X < Y, Min is X.
menor2( X,Y,Min ) :- Y <= X, Min is Y.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado minimo entre 3 valores: X,Y,Z,Minimo -> {V,F}

min3( X,Y,Z,Minimo ):- Minimo is min( X,min(Y,Z) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado par: X -> {V,F}
% o símbolo =:= representa o símbolo =

isPar( X ) :- mod( X,2 ) =:= 0.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado impar: X -> {V,F}
% o símbolo =\= representa o símbolo !=

isImpar( X ) :- mod( X,2 ) =\= 0.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado maximo divisor comum: X,X,X -> {V,F}
% quando os valores forem iguais, esse é o valor do maximo divisor comum (mdc) e o cálculo está terminado.

mdc( X,X,X ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% se existirem dois números diferentes, trocar o valor do maior pela sua diferença ao menor e iterar o cálculo.

mdc( X,Y,D ) :- X < Y, Y1 is Y-X, mdc( X,Y1,D ).
mdc( X,Y,D ) :- X > Y, mdc( Y,X,D ).

% OUUUUUUU

% mdc(X,Y,R) :- X > Y, X1 is X-Y, mdc(X1,Y,R).
% mdc(X,Y,R) :- Y > X, Y1 is Y-X, mdc (X,Y1,R).
% mdc(X,X,X).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensão do predicado minimo multiplo comum: X,X,X -> {V,F}

mmc( X,Y,D ) :- mdc( X,Y,MDC ), D is X * Y / MDC.

% mmc( X,X,X ).
