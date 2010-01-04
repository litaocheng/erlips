%%%----------------------------------------------------------------------
%%%
%%% litaocheng @copyright © 2009 
%%%
%%% @author litaocheng@gmail.com
%%% @doc erlips types define file
%%%
%%%----------------------------------------------------------------------

%% the type defines
-type http_code() :: pos_integer().
-type header_list() :: [{binary() | string(), binary() | string()}].
