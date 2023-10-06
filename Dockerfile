FROM php:8.2-cli-bookworm

RUN set -eux; \
	    apt-get update; \
	    apt-get install -y --no-install-recommends \
        ca-certificates curl gnupg libzip-dev unzip libpng-dev libpq-dev

# pdo_pgsql is the missing link
RUN docker-php-ext-install zip gd pgsql pdo_pgsql sysvsem

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  \
        && php composer-setup.php \
        && php -r "unlink('composer-setup.php');" \
        && chmod +x composer.phar && mv composer.phar /usr/local/bin/composer \
        && echo "memory_limit = 256M" > /usr/local/etc/php/conf.d/php-memory-limit.ini

RUN mkdir -p /etc/apt/keyrings \
        && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
        | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
        | tee /etc/apt/sources.list.d/nodesource.list \
        && apt-get install -y --no-install-recommends nodejs npm

VOLUME ["/app"]

WORKDIR /app

ENTRYPOINT ["bash"]
