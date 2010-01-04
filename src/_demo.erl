%%%----------------------------------------------------------------------
%%%
%%% @copyright 2009 erlips
%%%
%%% @author litaocheng@gmail.com
%%% @doc the demo module handle the request path:
%%%  "http://host/demo"
%%% @end
%%%
%%%----------------------------------------------------------------------
-module('_demo').
-author('ltiaocheng@gmail.com').
-vsn('0.1').
-include("erlips.hrl").
-include("erlips_type.hrl").

-export([handle/2]).

%% @doc handle the http request
-spec handle(Req :: atom(), Method :: atom()) -> 
    {http_code(), header_list(), iolist()}.
handle(Req, Method) ->
    ?DEBUG2("handle request :~p ~n", [Req]),
    IpStr = Req:get(peer), 
    Headers = Req:get(headers),

    ReqHeaders =
    lists:foldr(fun({K, V}, Acc) ->
            [lists:concat([K, " : ", V, "\n"]) | Acc]
    end,
    [],
    mochiweb_headers:to_list(Headers)),

    Query = Req:parse_qs(),
    Post = Req:parse_post(),

    RspStr = 
    io_lib:format(<<
            "It Works!~n~nHello, Your IP is ~s~nmethod: ~s~nqurey string:~p~npost body:~p~nRequest Data:~n">>,
            [IpStr, Method, Query, Post]),

    ?DEBUG2("response is:~p ~n", [RspStr]),
    {200, [], [RspStr, ReqHeaders]}.
