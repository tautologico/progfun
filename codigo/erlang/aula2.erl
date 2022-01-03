-module(aula2).

-export([soma/2, mult/2, tamanho/1]).

% funcoes recursivas para soma e multiplicacao
soma(M, 0) -> M;
soma(M, N) -> soma(M+1, N-1).

mult(_M, 0) -> 0;
mult( M, N) -> M + mult(M, N-1).

% alguns exemplos de listas
listas() ->
    Lista1 = [ 1 | [] ],
    Lista2 = [ 2 | Lista1 ],
    ([1] == Lista1) and ([2, 1] == Lista2).

% tamanho de listas
tamanho([]) -> 0;
tamanho([_ | T]) -> 1 + tamanho(T).
