-module(super_manager).
-behaviour(supervisor).
-export([start_link/0,init/1]).

start_link()->
    supervisor:start_link(super_manager,[]).

init(_Args)->
    SupFlags = #{ strategy => one_for_one },
    ChildSpec = [#{
        id=> rest1,
        start => { restaurant_online,start_link,[{"Z",5}] },
        restart => transient
    }],
    {ok,{SupFlags,ChildSpec}}.