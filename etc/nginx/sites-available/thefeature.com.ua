server {
    listen 80;
    server_name thefeature.com.ua;

    charset utf-8;
    autoindex on;
    access_log /var/log/nginx/thefeature.com.ua.access.log;
    error_log /var/log/nginx/thefeature.com.ua.error.log;

    set $root /var/www/thefeature.com.ua;
    root $root;

    location /favicon.ico {
        root $root;
    }

    location /blocks/ {
        root $root;
    }

    location /pages/ {
        root $root;
    }

    location / {
        try_files $uri @nodejs;
    }

    location @nodejs {
        proxy_pass http://localhost:8787;
        proxy_set_header HOST $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-NginX-Proxy true;
        proxy_redirect off;
    }

}

server {
    listen 80;
    server_name www.thefeature.com.ua;

    rewrite ^/(.*) http://thefeature.com.ua permanent;
}