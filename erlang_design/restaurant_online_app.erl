-module(restaurant_online_app).
-behaviour(application).
-export([start/2,stop/1]).

start(_Type,_Args)->
    super_manager:start_link().

stop(_State)->
    ok.