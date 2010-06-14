%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc TEMPLATE.

-module({{appid}}).
-author('author <author@example.com>').
-export([start/0, stop/0]).

ensure_started(App) ->
    case application:start(App) of
        ok ->
            ok;
        {error, {already_started, App}} ->
            ok
    end.

%% @spec start() -> ok
%% @doc Start the {{appid}} server.
start() ->
    {{appid}}_deps:ensure(),
    ensure_started(crypto),
    application:start({{appid}}).

%% @spec stop() -> ok
%% @doc Stop the {{appid}} server.
stop() ->
    Res = application:stop({{appid}}),
    application:stop(crypto),
    Res.
