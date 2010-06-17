#!/bin/sh
cd `dirname $0`
./rebar compile
exec erl -pa $PWD/apps/*/ebin -boot start_sasl -config rel/overlay/etc/app.config -s reloader -s {{appid}}
