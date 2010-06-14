{application, {{appid}},
 [{description, "{{appid}}"},
  {vsn, "0.9"},
  {modules, [
    {{appid}},
    {{appid}}_app,
    {{appid}}_sup,
    {{appid}}_web,
    {{appid}}_deps
  ]},
  {registered, []},
  {mod, {{{appid}}_app, []}},
  {env, []},
  {applications, [kernel, stdlib, crypto]}]}.
