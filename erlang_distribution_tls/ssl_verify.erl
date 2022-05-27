-module(ssl_verify).
-export([verify/3]).

verify(_,{bad_cert, _}, UserState) ->
	  {valid, UserState};
verify(_,{extension, {critical = true}}, UserState) ->
	  {valid, UserState};
verify(_,{extension, _}, UserState) ->
	  {unknown, UserState};
verify(_, valid, UserState) ->
	  {valid, UserState};
verify(_, valid_peer, UserState) ->
      {valid, UserState}.
