-module(collections).
-compile([export_all]).
-record(human,{name="unknow",age=0,gender}).
-record(manager,{ceo = #human{},ctop = #human{}}).

% get a element from tuple
test_tuple_get_element()->
    T = {normal,high},
    element(1,T).

% get a default value of record key
test_record()->
    H = #manager{},
    H#manager.ceo.
