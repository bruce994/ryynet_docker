#!/bin/bash
#可以加入开机启动脚本中 chmod +x /etc/rc.local
#/bin/bash /home/web_php_restart.sh

service docker start

cd /home/ryynet_docker/
docker rm mysql --force
docker rm php7.2 --force
docker rm golang-gin --force
docker rm redis --force
docker rm lanren --force
docker rm guest --force
docker rm guest1 --force
docker rm payUser --force
docker rm payUser2 --force
docker rm test --force
docker rm virtural --force
docker rm lanren-haibao --force
docker rm web --force

#不要暴露端口
rm -rf redis_data
docker run --name redis -d -v "$PWD"/redis.conf:/usr/local/etc/redis/redis.conf  -v "$PWD"/redis_data:/data  -it redis:latest

#mysql 经常被黑
#docker run --name mysql -d -p 3306:3306 -v "$PWD"/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=b29VURchQW-d-S2Y -it mysql:5.7.21

docker run -d -p 9000:9000 --cpus=1 --name lanren -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html   --link redis   -it 66856d081861
docker run -d -p 9001:9000 --cpus=0.2  --name guest -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html   --link redis   -it 66856d081861
docker run -d -p 9002:9000 --cpus=0.2  --name test -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html   --link redis   -it 66856d081861
docker run -d -p 9004:9000 --cpus=0.2  --name guest1 -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html --link redis   -it 66856d081861

docker run -d -p 9003:9000 --cpus=0.2  --name virtural  -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html  -v /home/ryynet1/www/bao.lanrenmb.com:/var/www/bao  -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html   --link redis   -it 66856d081861
docker run -d -p 9010:9000 --cpus=0.3  --name lanren-haibao -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html  -v /home/ryynet1/www/bao.lanrenmb.com:/var/www/bao  -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html   --link redis   -it 66856d081861
docker run -d -p 9005:9000 --cpus=1  --name payUser -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html   --link redis   -it 66856d081861
docker run -d -p 9006:9000 --cpus=1  --name payUser2 -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html  --link redis  -it 66856d081861
docker run -d -p 9007:9000 --cpus=1  --name php7.2 -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v /home/ryynet1:/var/www/html -v /home2/Guest:/var/www/html2  -v "$PWD"/php7.2.ini:/usr/local/etc/php/php.ini  -w /var/www/html  --link redis  -it 91f15866c89a

docker run -d -p 3000:3000  --name golang-gin  -v /home2/Guest:/go/src/app  -it e213acca81e6


#django
docker rm django-shop --force
cd /home/ryynet1/www/shop.lanrenmb.com/
#init_admin.py 初始管理员账号密码 生成环境
#docker run -d -p 8005:8000 --name django-bao1215 -v "$PWD":/usr/src/app -w /usr/src/app    -it 0ad66cc67d8f  bash -c "python manage.py makemigrations && python  manage.py migrate && python init_admin.py && /usr/local/bin/gunicorn --bind 0.0.0.0:8000 mysite.wsgi:application -w 2"
#开发环境
docker run -d -p 8005:8000 --name django-shop -v "$PWD":/usr/src/app -w /usr/src/app   -it 0ad66cc67d8f  bash -c "python manage.py runserver 0.0.0.0:8000"


cd /home/ryynet_docker/
docker run -d -p 80:80 -p 443:443 --name web -v "$PWD"/nginx.conf:/etc/nginx/nginx.conf:ro -v "$PWD"/logs:/var/log/nginx  -v /home/ryynet1:/usr/share/nginx/html:ro  -v /home2/Guest:/usr/share/nginx/html2:ro   -v /etc/localtime:/etc/localtime:ro  --link lanren  --link guest  --link guest1  --link payUser --link payUser2 --link django-shop --link test --link virtural --link lanren-haibao --link php7.2 --link golang-gin  -it ec7e83446356






