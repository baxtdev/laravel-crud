FROM php:8.1-fpm-alpine

# Install dependencies
RUN apk add --no-cache autoconf build-base git postgresql-dev

# Install and enable PostgreSQL PDO extension
RUN docker-php-ext-install pdo_pgsql

# Enable Opcache (already included in the base image)
RUN docker-php-ext-enable opcache

# Consider using a package manager for APC (optional)
# RUN pecl install apcu-5.1.21  # Adjust version as needed
# RUN docker-php-ext-enable apcu

# Install Composer
COPY --from=composer:2.1 /usr/bin/composer /usr/local/bin/composer

# Read environment variables from .env file (assuming it's in the same directory)
COPY .env .
RUN source .env

EXPOSE 9000

# Copy your application code
COPY . /var/www/html


# Access environment variables within your application using $DB_HOST, etc.
