-module(module1_SUITE).

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
suite() -> [{timetrap,{minutes,1}},
            {userdata, "hello"}
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
    Config.

%%--------------------------------------------------------------------
%% Function: end_per_suite(Config) -> _
%% Config: [tuple()]
%%   A list of key/value pairs, holding the test case configuration.
%% Description: Cleanup after the whole suite
%%--------------------------------------------------------------------
end_per_suite(_Config) ->
    ok.

%% init per test
init_per_testcase(test_log, Config) ->
    io:format("..init........~n~p.~p~n", [test_log, Config]),
    [{sex, male} | Config];
init_per_testcase(Name, Config) ->
    io:format("..init........~n~p.~p~n", [Name, Config]),
    Config.

end_per_testcase(test_log, Config) ->
    io:format("...end........~n~p~p~n", [test_log, Config]),
    {save_config, Config};
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
    [test_1, test_2].

%%-------------------------------------------------------------------------
%% Test cases starts here.
%%-------------------------------------------------------------------------
test_1() ->
    [{timetrap, {seconds, 60}}, {userdata,[{doc,"Perform an OPTIONS request that goes through a proxy."}]},
        {require, ftp},
        {default_config, ftp, [{ftp, "my_ftp_host"},
                               {username, "alladin"},
                               {password, "sesame"}]}
    ].
    
test_1(Config) ->
    ct:comment("...i'm a comment ~~~~~~~~~~~n"),
    {skip, not_impl}.

test_2(Config) ->
    io:format("config is~p~n", [Config]),
    catch 3 = 2,
    ok.
