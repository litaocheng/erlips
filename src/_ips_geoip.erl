%%%----------------------------------------------------------------------
%%%
%%% @copyright 2009 erlips 
%%%
%%% @author litaocheng@gmail.com 
%%% @doc the module handle the request path:
%%%  "http://host/ips/geoip"
%%% @end
%%%
%%%----------------------------------------------------------------------
-module('_ips_geoip').
-author('ltiaocheng@gmail.com').
-vsn('0.1').
-include("erlips.hrl").

-define(GET2(K, L), proplists:get_value(K, L)).
-define(GET3(K, L, Def), proplists:get_value(K, L, Def)).

-export([handle/2]).

%% @doc handle the /ips/geoip request
%% @spec handle(Req :: any(), Method :: atom()) -> 
%%    {pos_integer(), list(), iodata()}
-spec handle(Req :: any(), Method :: atom()) -> 
    {pos_integer(), list(), iodata()}.
handle(Req, 'GET') ->
    Ip = proplists:get_value("ip", []), 
    IpStr = Req:get(peer), 
    Query = Req:parse_qs(),
    QueryIp = ?GET3("ip", Query, IpStr),
    case egeoip:lookup(QueryIp) of
        {ok, GeoIP} ->
            ?DEBUG2("Query Ip is:~p~ngeoip:~p~n", [QueryIp, GeoIP]),
            {200, [], geoip_json(GeoIP)};
        {error, R} ->
            {200, [], error_json(R)}
    end.

%% geoip response
geoip_json(GeoIP) ->
    [<<"{\"country\":\"">>, egeoip:get(GeoIP, country_name), <<"\",">>,
         <<"\"region\":\"">>, egeoip:get(GeoIP, region), <<"\",">>,
         <<"\"city\":\"">>, egeoip:get(GeoIP, city), <<"\",">>,
         <<"\"long\":">>, f2s(egeoip:get(GeoIP, longitude)), <<",">>,
         <<"\"lat\":">>, f2s(egeoip:get(GeoIP, latitude)), <<"}">>
     ].

%% error response
error_json(Error) ->
    [<<"{\"error\":\"">>, io_lib:format("~p", [Error]), <<"\"}">>].
    

%% convert float to string
f2s(N) when is_integer(N) ->
    integer_to_list(N) ++ ".00";
f2s(F) when is_float(F) ->
    io_lib:format("~.2f", [F]).

-ifdef(EUNIT).
f2s_test_() ->
    [
        ?_assertEqual("2.00", f2s(2)),
        ?_assertEqual(["2.01"], f2s(2.01)),
        ?_assertEqual(["0.00"], f2s(0.00)),
        ?_assertEqual(["2.01"], f2s(2.0102)),
        ?_assertError(function_clause, f2s('2.00'))
    ].

-endif.
