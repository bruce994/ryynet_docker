#!/bin/bash
#可以加入开机启动脚本中 chmod +x /etc/rc.local
#/bin/bash /home/web_php_restart.sh

service docker start

cd /home/ryynet_docker/
docker rm mysql --force
docker rm lanren --force
docker rm guest --force
docker rm guest1 --force
docker rm payUser --force
docker rm payUser2 --force
docker rm test --force
docker rm virtural --force
docker rm web --force


docker run --name mysql -d -p 3306:3306 -v "$PWD"/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=b29VURchQW-d-S2Y -it mysql:5.7.21

docker run -d -p 9000:9000  --name lanren -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it cc98219e1882
docker run -d -p 9001:9000  --name guest -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it cc98219e1882
docker run -d -p 9002:9000  --name test -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it cc98219e1882
docker run -d -p 9003:9000  --name virtural  -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it cc98219e1882
docker run -d -p 9004:9000  --name guest1 -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it cc98219e1882


#--cpu-period 结合 --cpu-quota 配置是固定的，无论 CPU 是闲还是繁忙，如上配置，容器最多只能使用 2 个 CPU 到 100%。
docker run -d -p 9005:9000 --cpu-period=100000 --cpu-quota=200000  --name payUser -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it cc98219e1882

docker run -d -p 9006:9000 --cpu-period=100000 --cpu-quota=200000  --name payUser2 -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it cc98219e1882

cd /home/ryynet_docker/
docker run -d -p 80:80 -p 443:443 --name web -v "$PWD"/nginx.conf:/etc/nginx/nginx.conf:ro -v "$PWD"/logs:/var/log/nginx  -v /home/ryynet1:/usr/share/nginx/html:ro  -v /home2/Guest:/usr/share/nginx/html2:ro   -v /etc/localtime:/etc/localtime:ro  --link lanren  --link guest  --link guest1  --link payUser --link payUser2 --link test --link virtural   -it ec7e83446356










