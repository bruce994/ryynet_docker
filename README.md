# ** Docker php5.6 fpm  nginx  mysql 配置(懒人云科技专属配置)  **   #
#  操作说明 #
*  一、进入php_Dockerfile文件夹，运行 docker build -t php:5.6-fpm .  创建php:5.6-fpm镜像，这里包括了主要的组件如：zend gettext mysql mysqli opcache pdo_mysql sockets exif zip imagick等等（注意这里拉取国外镜像，推荐使用阿里云docker加速）
*  php5.6国内生成很慢，在这里我已经做好上传阿里云了，可以直接pull  (命令 docker pull registry.cn-hangzhou.aliyuncs.com/ryynet/php5.6:1.0)
* 二、在ryynet_docker目录下新建log  www  mysql  目录
* 三、直接执行./web_php_restart.sh 这样就会自动生成nginx、mysql容器，并且挂载日志目录log、网站目录www,数据库账号root,密码147258 (可以把该文件加入服务器启动项)
* 四、修改nginx配置文件，即可成功(注意，可以把不要的站点删除，结合自己的需求),把网站放在www目录下，这块根据自己需求设置

## 开发日志： ##
* 20190719 php.ini 增加 max_input_vars = 3000 提交表单限制
* 20191023 web_php_restart.sh  --cpus=1 限制容器能使用的 CPU 核数
* 20191024 nginx php轮询分流
```
一、nginx.conf 配置如下：
upstream bypass-php{
    server lanren-haibao:9000;
    server virtural:9000;
    server guest1:9000;
}

二、把fastcgi_pass xxxx:9000 改为bypass-php
location ~ \.php {
	 fastcgi_pass  bypass-php;
	 ... 

注意分流php fastcgi SCRIPT_FILENAME,PHP_VALUE 参数与主机保持一致
```

* 20200306 php5.6容器增加redis扩展
* 20200312 docker redis 移除端口(容易被黑,mysql容器也一样)



## 由于nginx docker 需要挂载多个目录,重新创建nginx容器 ##
```
FROM registry.cn-hangzhou.aliyuncs.com/ryynet/php5.6:1.0 
RUN mkdir -p /var/www/html2

```




```

使用脚本自动安装

在测试或开发环境中 Docker 官方为了简化安装流程，提供了一套便捷的安装脚本，CentOS 系统上可以使用这套脚本安装：
$ curl -fsSL get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh --mirror Aliyun
执行这个命令后，脚本就会自动的将一切准备工作做好，并且把 Docker CE 的 edge 版本安装在系统中。
启动 Docker CE

$ sudo systemctl enable docker
$ sudo systemctl start docker

———————————————安装或更新 docker-compose  ————

curl -L https://github.com/docker/compose/releases/download/1.19.0-rc1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
-------------------------------------------------------------------------------------------------------


 php5.6国内生成很慢，在这里我已经做好上传阿里云了，可以直接pull (命令 docker pull registry.cn-hangzhou.aliyuncs.com/ryynet/php5.6:1.0)
 php7.2国内生成很慢，在这里我已经做好上传阿里云了，可以直接pull (命令 docker pull registry.cn-hangzhou.aliyuncs.com/ryynet/php7.2:1.0)
 django-1.11.7阿里云镜像 （docker pull registry.cn-hangzhou.aliyuncs.com/ryynet/django-1.11.7:1.0）


———————————Centos--------------------------------------------------

针对Docker客户端版本大于1.10.0的用户

您可以通过修改daemon配置文件/etc/docker/daemon.json来使用加速器：
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://y332lds0.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
—————————————————————————-----------------------------

```




## php5.6-fpm 镜像如下： ##
```
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

# Install redis
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-2.2.7 /usr/src/php/ext/redis \
    && docker-php-ext-install redis

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

```

## php7.2-fpm 镜像如下： ##
```
FROM php:7.3.2-fpm-stretch
RUN apt-get update && \
    pecl channel-update pecl.php.net && \
    pecl install apcu igbinary mongodb && \
    # compile Redis with igbinary support
    pecl bundle redis && cd redis && phpize && ./configure --enable-redis-igbinary && make && make install && \
    docker-php-ext-install bcmath sockets pdo_mysql gd exif zip && \
    docker-php-ext-enable apcu igbinary mongodb opcache redis && \
    apt-get -y install libmagickwand-dev && \
    pecl install imagick  && \
    docker-php-ext-enable imagick && \
    docker-php-source delete && \
    rm -r /tmp/* /var/cache/* /var/www/html/*

    
RUN echo '\
opcache.interned_strings_buffer=16\n\
opcache.load_comments=Off\n\
opcache.max_accelerated_files=16000\n\
opcache.save_comments=Off\n\
' >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini
```


