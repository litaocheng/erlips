%%%----------------------------------------------------------------------
%%%
%%% @copyright 2009 erlips 
%%%
%%% @author litaocheng@gmail.com 
%%% @doc erlips app and supervisor callback
%%% @end
%%%
%%%----------------------------------------------------------------------
-module(erlipsapp).
-author('litaocheng@gmail.com').
-vsn('0.1').
-include("erlips.hrl").

-behaviour(application).
-behaviour(supervisor).

-export([start/0]).
-export([start/2, stop/1]).
-export([init/1]).


%% @doc start the application from the erl shell
-spec start() -> 'ok' | {'error', any()}.
start() ->
    ensure_apps(),
    ?DEBUG2("start the ~p~n", [?MODULE]),
    erlips_ctl:init(),
    application:start(erlips).

%% @doc the application start callback
-spec start(Type :: atom(), Args :: any()) ->
    'ignore' | {'ok', pid()} | {'error', any()}.
start(_Type, _Args) ->
    ?DEBUG2("start the supervisor sup ~n", []),
    supervisor:start_link({local, erlips_sup}, ?MODULE, []).

%% @doc the application  stop callback
stop(_State) ->
    ok.

%% @doc supervisor callback
init(_Args) -> 
    Stragegy = {one_for_one, 10, 10},

    ModGeoip = {egeoip, {egeoip, start, []},
                permanent, 2000, worker, [egeoip]},
    ModHttpd = {erlips_httpd, {erlips_httpd, start_link, []},
                permanent, 2000, worker, [erlips_httpd]},

    {ok, {Stragegy, [
                    ModGeoip,
                    ModHttpd 
                    ]}
    }.

%%
%% internal API
%%

%% first ensure some apps must start
ensure_apps() ->
    application:start(sasl),
    ok.
