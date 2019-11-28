FROM nginx:alpine

LABEL maintainer="Marc-André Appel <marc-andre@appel.fun>"

RUN apk update && apk add supervisor && echo "daemon off;" >> /etc/nginx/nginx.conf

COPY h5bp /etc/nginx/h5bp
COPY default /etc/nginx/sites-available/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
