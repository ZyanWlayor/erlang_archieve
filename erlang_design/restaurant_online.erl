-module(restaurant_online).
-behaviour(gen_statem).
-record(restauant_online_data,{name = "default",orders = [],orders_limit = 20}).
-export([start_link/1,init/1,terminate/3]).
-export([callback_mode/0]).
-export([suspension/3,open/3]).


start_link(Args)->
    gen_statem:start_link({local,restaurant_online},restaurant_online,Args,[]).

init({Name,Orders_limit})->
    {ok,suspension,#restauant_online_data{name = Name,orders_limit = Orders_limit}}.

callback_mode()->
    state_functions.

suspension({call,From},get_orders,Restauant_online_data)->
    {keep_state_and_data,[{reply,From,Restauant_online_data#restauant_online_data.orders}]};
suspension({call,From},get_orders_limit,Restauant_online_data)->
    {keep_state_and_data,[{reply,From,Restauant_online_data#restauant_online_data.orders_limit}]};
suspension({call,From},{order,_Goods},_Restauant_online_data)->
    {keep_state_and_data,[{reply,From,state_suspension}]};
suspension({call,From},_Call,_Restauant_online_data)->
    {keep_state_and_data,[{reply,From,unknow_call}]};
suspension(cast,open,Restauant_online_data)->
    {next_state,open,Restauant_online_data,[{state_timeout,180000,suspension}]}. % open for 3min

open({call,From},{order,Goods},Restauant_online_data)->
    if
        length(Restauant_online_data#restauant_online_data.orders) < Restauant_online_data#restauant_online_data.orders_limit ->
            {repeat_state,Restauant_online_data#restauant_online_data{ orders =  [ Goods | Restauant_online_data#restauant_online_data.orders]},[{ reply,From,order_accept }]};
        true ->
            {repeat_state_and_data,[{ reply,From,order_queue_too_long }]}
    end;
open({call,From},get_orders,Restauant_online_data)->
    {keep_state_and_data,[{reply,From,Restauant_online_data#restauant_online_data.orders}]};
open({call,From},get_orders_limit,Restauant_online_data)->
    {keep_state_and_data,[{reply,From,Restauant_online_data#restauant_online_data.orders_limit}]};
open(state_timeout,suspension,Restauant_online_data)->
    {next_state,suspension,Restauant_online_data}.

terminate(Reason,_State,_Data)->
    io:format("======Reason: ~s~n",[term_to_binary(Reason)]).