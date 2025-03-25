server {
    if ($host = api.sentosafishery.com) {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    listen 80;
    server_name api.sentosafishery.com;
    return 301 https://$host$request_uri;  # Redirect semua HTTP ke HTTPS


}

server {
    listen 443 ssl;
    server_name api.sentosafishery.com;
    ssl_certificate /etc/letsencrypt/live/api.sentosafishery.com/fullchain.pem; # managed by Certbot
    ssl_certificate_key /etc/letsencrypt/live/api.sentosafishery.com/privkey.pem; # managed by Certbot
    include /etc/letsencrypt/options-ssl-nginx.conf;

    location / {
        proxy_pass http://sentosa-api:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Authorization $http_authorization;
    }

}

