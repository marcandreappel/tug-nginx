FROM nginx:alpine

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.vendor="Marc-André Appel <marc-andre@appel.fun>" \
    org.label-schema.name="marcandreappel/tug-nginx" \
    org.label-schema.description="A small nginx Docker Image" \
    org.label-schema.url="https://hub.docker.com/r/marcandreappel/tug-nginx" \
    org.label-schema.build-date=$DATE \
    org.label-schema.version="$VERSION" \
    org.label-schema.vcs-url="$URL" \
    org.label-schema.vcs-branch="$BRANCH" \
    org.label-schema.vcs-ref="$COMMIT"

RUN apk update && apk add supervisor \
	&& echo "daemon off;" >> /etc/nginx/nginx.conf \
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY h5bp /etc/nginx/h5bp
COPY default /etc/nginx/sites-available/default
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
