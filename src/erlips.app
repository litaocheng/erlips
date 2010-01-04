{application, erlips,
    [{description, "Erlang Ip Services App"},
     {vsn, "0.1"},
     {modules, [
                erlipsapp,
                egoip,
                erlips_httpd,
                erlips_ctl,
                '_demo',
                '_echo',
                '_ips_geoip'
                ]},
     {registered, []},
     {applications, [kernel, stdlib, sasl]},
     {mod, {erlipsapp, []}},
     {env, [
             {doc_root, "./www"},
             {ip, "0.0.0.0"},
             {port, 8080},
             {max, 5000},
             {http_handler_dirs, ["./ebin"]}
         ]}
    ]
}.
