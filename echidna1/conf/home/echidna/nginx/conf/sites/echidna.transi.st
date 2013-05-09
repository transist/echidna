upstream echidna_rails {
    # fail_timeout=0 means we always retry an upstream even if it failed
    # to return a good HTTP response (in case the Unicorn master nukes a
    # single worker for timing out).

    # for UNIX domain socket setups:
    server unix:///home/echidna/echidna.transi.st/current/tmp/sockets/echidna.socket fail_timeout=0;
}

server {
    listen 80;
    server_name echidna.transi.st;

    client_max_body_size 4G;
    keepalive_timeout 5;

    root /home/echidna/echidna.transi.st/current/public;
    try_files $uri/index.html $uri.html $uri @app;

    auth_basic "Restricted";
    auth_basic_user_file htpasswd;

    location @app {
        # an HTTP header important enough to have its own Wikipedia entry:
        #   http://en.wikipedia.org/wiki/X-Forwarded-For
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        # enable this if you forward HTTPS traffic to unicorn,
        # this helps Rack set the proper URL scheme for doing redirects:
        # proxy_set_header X-Forwarded-Proto $scheme;

        # pass the Host: header from the client right along so redirects
        # can be set properly within the Rack application
        proxy_set_header Host $http_host;

        # we don't want nginx trying to do something clever with
        # redirects, we set the Host: header above already.
        proxy_redirect off;

        # set "proxy_buffering off" *only* for Rainbows! when doing
        # Comet/long-poll/streaming.  It's also safe to set if you're using
        # only serving fast clients with Unicorn + nginx, but not slow
        # clients.  You normally want nginx to buffer responses to slow
        # clients, even with Rails 3.1 streaming because otherwise a slow
        # client can become a bottleneck of Unicorn.
        #
        # The Rack application may also set "X-Accel-Buffering (yes|no)"
        # in the response headers do disable/enable buffering on a
        # per-response basis.
        # proxy_buffering off;

        proxy_pass http://echidna_rails;
    }

    # Rails error pages
    error_page 500 502 503 504 /500.html;
    # location = /500.html {
        # root /path/to/app/current/public;
    # }
}

# vim: set ft=conf:
