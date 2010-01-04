-module(geoip_SUITE).

%% Note: This directive should only be used in test suites.
-compile(export_all).

-include("ct.hrl").

%%--------------------------------------------------------------------
%% Test server callback functions
%%--------------------------------------------------------------------

%%--------------------------------------------------------------------
%% Function: suite() -> DefaultData
%% DefaultData: [tuple()]  
%% Description: Require variables and set default values for the suite
%%--------------------------------------------------------------------
suite() -> [{timetrap,{minutes,1}}
            ].

%%--------------------------------------------------------------------
%% Function: init_per_suite(Config) -> Config
%% Config: [tuple()]
%%   A list of key/value pairs, holding the test case configuration.
%% Description: Initiation before the whole suite
%%
%% Note: This function is free to add any key/value pairs to the Config
%% variable, but should NOT alter/remove any existing entries.
%%--------------------------------------------------------------------
init_per_suite(Config) ->
    inets:start(),
    Config.

%%--------------------------------------------------------------------
%% Function: end_per_suite(Config) -> _
%% Config: [tuple()]
%%   A list of key/value pairs, holding the test case configuration.
%% Description: Cleanup after the whole suite
%%--------------------------------------------------------------------
end_per_suite(_Config) ->
    inets:stop(),
    ok.

%% init per test
init_per_testcase(Name, Config) ->
    io:format("..init........~n~p.~p~n", [Name, Config]),
    Config.

end_per_testcase(Name, Config) ->
    io:format("...end........~n~p~p~n", [Name, Config]),
    ok.
%%--------------------------------------------------------------------
%% Function: all() -> TestCases
%% TestCases: [Case] 
%% Case: atom()
%%   Name of a test case.
%% Description: Returns a list of all test cases in this test suite
%%--------------------------------------------------------------------      
all() -> 
    [test_egeoip].

%%-------------------------------------------------------------------------
%% Test cases starts here.
%%-------------------------------------------------------------------------
test_egeoip() ->
    [
        {timetrap, {seconds, 1}} 
    ].
    
test_egeoip(Config) ->
    Url = "http://127.0.0.1:8080/ips/geoip?ip=123.8.36.125",    
    ?line Result = http:request(get, {Url, []}, [], [{sync, true}, {full_result, false}]),

    case Result of
        {ok, {200, Body}} ->
            case mochijson2:decode(Body) of
                {struct, Props} ->
                    proplists:get_value(<<"country">>, Props) =:= <<"China">> andalso
                    proplists:get_value(<<"region">>, Props) =:= <<"22">> andalso
                    proplists:get_value(<<"city">>, Props) =:= <<"Beijing">>
            end;
        Other ->
            io:format("http request ret:~p~n", [Other]),
            ct:comment("request the server error"),
            throw({http, request})
    end.
    
