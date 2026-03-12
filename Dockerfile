FROM php:8.2-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && docker-php-ext-install pdo pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy application files
COPY . /var/www/html/
WORKDIR /var/www/html

# Install PHP dependencies with Composer
RUN composer install --no-dev --optimize-autoloader

# Create cache and log directories
RUN mkdir -p var/cache var/log

# Expose port 9000
EXPOSE 9000
CMD ['php-fpm']