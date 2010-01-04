%%%----------------------------------------------------------------------
%%%
%%% litaocheng @copyright © 2009 
%%%
%%% @author litaocheng@gmail.com
%%% @doc erlips header file
%%%
%%%----------------------------------------------------------------------

%% the log macro
-ifdef(DEBUG).
-define(DEBUG2(F, D), io:format(F, D)).
-else.
-define(DEBUG2(F, D), ok).
-endif.
-define(INFO2(F, D), io:format(F, D)).
-define(WARN2(F, D), io:format(F, D)).
-define(ERROR2(F, D), io:format(F, D)).
-define(FATAL2(F, D), io:format(F, D)).

%% the config macro
-define(CONF_GET2(K, Def), (
        try element(2, application:get_env(erlips, K))
        catch _:_ ->
            Def
        end)).

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-endif.
                
