Some rebar templates to create a bare minimum mochiweb web app. Work in progress

To get started clone this repo

	git clone git://github.com/russelldb/rebar_templates.git
	mkdir new_web_proj
	cd new_web_proj
	ln -s ../rebar_templates/templates .templates
	./rebar create template=mochi appid=myweb nodeid=myweb
	./rebar get-deps compile
	chmod +x start_dev.sh
	./start_dev.sh

Then code, code, code. Add templates to rel/overlay/site/templates. Add static to rel/overlay/site/www. Add erlang to apps/myweb/src. When you compile your .erl it will be reloaded by reloader. When you add or change templates they will be compiled by tempile.

When you are happy with your app

	./rebar generate
	chmod +x rel/myweb/bin/myweb
	cd rel/myweb
	bin/myweb console or bin/myweb start

and test it some more

when you want to release

	cd rel
	tar cvf myweb.tar myweb/

and deploy the tar to *that same architecture*


TODO
* Add vagrant support so that we can have a dev and deploy env to play with and test on
