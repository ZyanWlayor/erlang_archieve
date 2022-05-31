-module(functions).
-export([test_fun/0,test_match/1]).

% high order function
test_fun()->
    C = 1,
    fun(X)->X+C end.

% test function params guard expression
test_match(<<25,O/binary>>) when is_binary(O)->
    O.
