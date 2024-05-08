https://github.com/g-hanwen/hugo-theme-nostyleplease

# server website through nginx

#
sudo apt update
sudo apt install nginx


# 

| sudo vim /etc/nginx/sites-available/mydomain.com

server {
    server_name mydomain.com www.mydomain.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # listen [::]:443 ssl ipv6only=on; # managed by Certbot
    # listen 443 ssl; # managed by Certbot
    # ssl_certificate /etc/letsencrypt/live/mydomain.com/fullchain.pem; # managed by Certbot
    # ssl_certificate_key /etc/letsencrypt/live/mydomain.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}

server {
    if ($host = www.mydomain.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 443 ssl;
    listen [::]:443 ssl;
    server_name mydomain.com www.mydomain.com;

    ssl_certificate /etc/letsencrypt/live/mydomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/mydomain.com/privkey.pem;

    include /etc/nginx/snippets/ssl-params.conf;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }


}
server {
    if ($host = mydomain.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    listen [::]:80;
    server_name mydomain.com www.mydomain.com;
    return 404; # managed by Certbot
}

#
sudo nano /etc/nginx/snippets/ssl-params.conf

ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers on;
ssl_ciphers "EECDH+AESGCM:EDH+AESGCM";
ssl_ecdh_curve secp384r1;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;
add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
add_header X-XSS-Protection "1; mode=block";

# 
sudo ufw allow 'Nginx Full'
sudo ufw reload


# 
sudo ln -s /etc/nginx/sites-available/yourdomain.com /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

# 
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com

#

server {
    server_name mydomain.com www.mydomain.com;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    # listen [::]:443 ssl ipv6only=on; # managed by Certbot
    # listen 443 ssl; # managed by Certbot
    # ssl_certificate /etc/letsencrypt/live/mydomain.com/fullchain.pem; # managed by Certbot
    # ssl_certificate_key /etc/letsencrypt/live/mydomain.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot


}

server {
    if ($host = www.mydomain.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 443 ssl;
    listen [::]:443 ssl;
    server_name mydomain.com www.mydomain.com;

    ssl_certificate /etc/letsencrypt/live/mydomain.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/mydomain.com/privkey.pem;

    include /etc/nginx/snippets/ssl-params.conf;

    location / {
        proxy_pass http://localhost:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }


}
server {
    if ($host = mydomain.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    listen [::]:80;
    server_name mydomain.com www.mydomain.com;
    return 404; # managed by Certbot
}


# slow docker context

https://stackoverflow.com/a/77363155/7195250


# https://www.docker.com/blog/how-to-deploy-on-remote-docker-hosts-with-docker-compose/#:~:text=There%20are%20three%20ways%20to%20deploy%20it%20on,target%20engine%20...%203%203.%20Using%20docker%20contexts


# how the dns resolve works
# create server
# create domain