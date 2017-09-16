FROM php:5.6-fpm

MAINTAINER wang<1330407081@qq.com>

# 更换(debian 8)软件源
# RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak
# ADD data/resources/debian8.sources    /etc/apt/sources.list

# extions

# Install Core extension
#
# bcmath bz2 calendar ctype curl dba dom enchant exif fileinfo filter ftp gd gettext gmp hash iconv
# imap interbase intl json ldap mbstring mcrypt mssql mysql mysqli oci8 odbc opcache pcntl
# pdo pdo_dblib pdo_firebird pdo_mysql pdo_oci pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix
# pspell readline recode reflection session shmop simplexml snmp soap sockets spl standard
# sybase_ct sysvmsg sysvsem sysvshm tidy tokenizer wddx xml xmlreader xmlrpc xmlwriter xsl zip
#
# Must install dependencies for your extensions manually, if need.
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \

    # no dependency extension
    && docker-php-ext-install gettext mysql mysqli opcache pdo_mysql sockets exif zip

# Install imagick
RUN apt-get install -y libmagickwand-dev --no-install-recommends && rm -rf /var/lib/apt/lists/*  && \
curl -L http://pecl.php.net/get/imagick-3.4.0.tgz >> /usr/local/lib/php/extensions/no-debug-non-zts-20131226/imagick.tgz && \
tar -xf /usr/local/lib/php/extensions/no-debug-non-zts-20131226/imagick.tgz -C /usr/local/lib/php/extensions/no-debug-non-zts-20131226/ && \
rm /usr/local/lib/php/extensions/no-debug-non-zts-20131226/imagick.tgz

RUN docker-php-ext-install /usr/local/lib/php/extensions/no-debug-non-zts-20131226/imagick-3.4.0

# Install PECL extensions
RUN apt-get install -y \

    # for memcache
    libmemcache-dev \

    # for memcached
    libmemcached-dev \

    && pecl install memcache && docker-php-ext-enable memcache \
    && pecl install memcached && docker-php-ext-enable memcached \
    && pecl install gearman && docker-php-ext-enable gearman \

    && pecl install xdebug && docker-php-ext-enable xdebug \
    && pecl install redis && docker-php-ext-enable redis \
    && pecl install xhprof && docker-php-ext-enable xhprof \

    && docker-php-source delete \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && echo 'PHP 5.6 installed.'
