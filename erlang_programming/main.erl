-module(main).
-export([list_length/1,test_length/0]).

list_length([_Head|Extra])->
    1+list_length(Extra);
list_length([])->
    0.

test_length()->
    io:format("~ts~n",["你们"]).