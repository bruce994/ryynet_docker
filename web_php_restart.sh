#!/bin/bash
#可以加入开机启动脚本中 chmod +x /etc/rc.local
#/bin/bash /home/web_php_restart.sh

service docker start
cd /home2/ryynet_docker/ 
docker rm mysql --force
docker rm php5.6 --force
docker rm php5.6-crm0831 --force
docker rm web --force
docker run --name mysql -d -p 3306:3306 -v "$PWD"/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=147258 -it mysql

docker run -d -p 9000:9000   --name php5.6 -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v "$PWD":/var/www/html -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it php:5.6-fpm
docker run -d -p 9001:9000  --name php5.6-crm0831 -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v "$PWD":/var/www/html -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it php:5.6-fpm

docker run -d -p 80:80 --name web -v "$PWD"/nginx.conf:/etc/nginx/nginx.conf:ro -v "$PWD"/logs:/var/log/nginx  -v "$PWD":/usr/share/nginx/html:ro -v /etc/localtime:/etc/localtime:ro  --link php5.6  --link php5.6-crm0831 -it nginx
