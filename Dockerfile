FROM php:8.2-fpm
WORKDIR /var/www
RUN apt-get update && apt-get install -y libpng-dev zip git curl libonig-dev
RUN docker-php-ext-install pdo mbstring pdo_mysql exif pcntl bcmath gd
COPY . .
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install
RUN chown -R www-data:www-data storage bootstrap/cache
RUN chmod -R 775 storage bootstrap/cache
RUN find . -type f -exec chmod 664 {} \;
RUN find . -type d -exec chmod 775 {} \;
RUN git config --global --add safe.directory /var/www
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["php-fpm"]
