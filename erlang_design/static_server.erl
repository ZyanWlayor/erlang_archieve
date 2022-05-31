-module(static_server).
-behaviour(gen_server).
-export([start_link/0,init/1,terminate/2,handle_call/3,handle_cast/2,handle_info/2]).

start_link()->
    gen_server:start_link({local,static_server},static_server,[],[]).

init(_Args)->
    {ok,[]}.

terminate(_,_)->
    ok.

handle_call(_Req,_From,_State)->
    {reply,javascript,[]}.

handle_cast(_Req,_State)->
    {noreply,[]}.

handle_info(Info,_State)->
    io:format("~s",[term_to_binary(Info)]),
    {noreply,[]}.
