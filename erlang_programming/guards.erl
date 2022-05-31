-module(guards).
-export([test_guard_condition_and/1]).

% test function guard condition and.
test_guard_condition_and(X) when X>3, is_integer(X) ->
    gt3.

