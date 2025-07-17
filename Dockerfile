FROM php:8.2-fpm
WORKDIR /var/www
RUN apt-get update && apt-get install -y libpng-dev zip git curl libonig-dev
RUN docker-php-ext-install pdo mbstring pdo_mysql exif pcntl bcmath gd
COPY . .
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install
EXPOSE 9000
CMD ["php-fpm"]
