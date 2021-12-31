-module(aula1).
-export([f/1, raiz_positiva/3, soma_N/1]).

f(X) ->
    X * 20.

% equacoes de segundo grau
delta(A, B, C) ->
    (B * B) - (4 * A * C).

raiz_positiva(A, B, C) ->
    (-B + math:sqrt(delta(A, B, C))) / (2 * A).

% soma dos N primeiros numeros
soma_N(N) when N =:= 1 -> 1;
soma_N(N) ->
    N + soma_N(N - 1).
