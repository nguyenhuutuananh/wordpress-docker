FROM wordpress
COPY php/custom.ini $PHP_INI_DIR/conf.d/

RUN docker-php-ext-install mysqli pdo pdo_mysql
