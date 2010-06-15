%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Web server for {{appid}}.

-module({{appid}}_web).
-author('author <author@example.com>').

-export([start/0, stop/0, loop/2]).

%% External API

start() ->
   %% Read config...
    {ok, BindAddress} = application:get_env({{appid}}, bind_address),
    {ok, Port} = application:get_env({{appid}}, port),
    {ok, ServerName} = application:get_env({{appid}}, server_name),
    {ok, DocRoot} = application:get_env({{appid}}, document_root),

    Loop = fun (Req) ->
		   ?MODULE:loop(Req, DocRoot)
	   end,

    Options = [
        {name, ServerName},
        {ip, BindAddress}, 
        {port, Port},
        {loop, Loop}
    ],

    error_logger:info_msg("Starting mochiweb with options: ~p~n", [Options]),

    mochiweb_http:start(Options).

stop() ->
    mochiweb_http:stop(?MODULE).

loop(Req, DocRoot) ->
    "/" ++ Path = Req:get(path),
    case Req:get(method) of
        Method when Method =:= 'GET'; Method =:= 'HEAD' ->
			View = get_view(Path),
			case tempile:render(View, [{current, View}]) of
				{ok, RespBody} ->
					Req:respond({200, [{"Content-Type", "text/html; charset=UTF-8"}], RespBody});
				_ ->
					Req:serve_file(Path, DocRoot)
			end;
        'POST' ->
            case Path of
				"f" ->
					Post = Req:parse_post(),
					Req:respond(mail_it(Post)); 
                _ ->
                    Req:not_found()
            end;
        _ ->
            Req:respond({501, [], []})
    end.

%% Internal API
%% Figure out the view name
get_view("") ->
	"index";
get_view(Path) ->
	filename:rootname(filename:basename(Path)).

%% Send the email
mail_it(Post) ->
    Subject = get_subject(Post),
    Body = get_body(Post),
    erlgmail:psend(Subject, Body, {{appid}}),
    {302,
     [{"Location", "/thanks.html"},
      {"Content-Type", "text/html; charset=UTF-8"}],
     ""}.

get_body(L) ->
    to_message(L, []).

to_message([], Message) -> lists:reverse(Message);
to_message([{Key, undefined}|T], Message) ->
    to_message(T, [string:concat(string:concat(Key, ": "),"undefined\r\n")|Message]);
to_message([{Key, Value}|T], Message) ->
    to_message(T, [string:concat(string:concat(Key, ": "),Value ++"\r\n")|Message]).

get_subject(L) ->
    "Subject: " ++ proplists:get_value("action", L, "Unknown Action").


%%
%% Tests
%%
-include_lib("eunit/include/eunit.hrl").
-ifdef(TEST).
-endif.
