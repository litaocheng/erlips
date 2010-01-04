%%%----------------------------------------------------------------------
%%%
%%% @copyright 2009 erlips
%%%
%%% @author litaocheng@gmail.com
%%% @doc the echo module 
%%% @end
%%%
%%%----------------------------------------------------------------------
-module('_echo').
-author('ltiaocheng@gmail.com').
-vsn('0.1').
-include("erlips.hrl").

-export([handle/2]).

handle(_Req, _Method) ->
    {200, [], <<"ok">>}.
