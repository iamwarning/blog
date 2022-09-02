FROM php:7.4.29-fpm-alpine3.16
RUN apk add oniguruma-dev postgresql-dev libxml2-dev
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-install \
        bcmath \
        ctype \
        fileinfo \
        json \
        mbstring \
        pdo_mysql \
        pdo_pgsql \
        tokenizer \
        xml
WORKDIR /app
COPY . /app
RUN composer install --no-interaction --optimize-autoloader --no-dev
EXPOSE 80
CMD php artisan serve --host=0.0.0.0 --port=80
