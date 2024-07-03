FROM php:8.3-apache

# Instalar dependências
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libicu-dev \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-install intl \
    && a2enmod rewrite

# Copiar configuração do Apache
COPY . /var/www/html

# Configurar permissões
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

RUN a2enmod rewrite

# Configuração do Apache
COPY ./apache-config.conf /etc/apache2/sites-available/000-default.conf

# Expor a porta 80
EXPOSE 80