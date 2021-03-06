#!/bin/bash
#可以加入开机启动脚本中 chmod +x /etc/rc.local
#/bin/bash /home/web_php_restart.sh

service docker start

cd /home2/ryynet_docker/
docker rm mysql --force
docker rm php5.6 --force
docker rm web --force

docker run --name mysql -d -p 3306:3306 -v "$PWD"/mysql:/var/lib/mysql -v "$PWD"/mysql.cnf:/etc/mysql/conf.d/mysql.cnf  -e MYSQL_ROOT_PASSWORD=b29VURchQW-d -e TZ='Asia/Shanghai'  -it mysql:5.7.21

#php5.6
docker run -d -p 9000:9000   --name php5.6 -v "$PWD"/php-fpm.d:/usr/local/etc/php-fpm.d  -v "$PWD":/var/www/html -v "$PWD"/php.ini:/usr/local/etc/php/php.ini  -w /var/www/html    --link mysql:mysql  -it 66856d081861

#golang gin
docker rm go-202003 --force
docker run -d  --name go-202003  -v /home2/ryynet_docker/www:/go/src/app -v /home2/ryynet_docker/www/vote/Service/common:/go/src/common  -v /etc/localtime:/etc/localtime:ro --link  mysql  -it a59cdbf09522  bash -c "cd src/app/vote/Service/ && fresh"


#django
docker rm django-20171215 --force
cd /home2/ryynet_docker/www/20171215.tp.lanrenmb.cn/
#init_admin.py 初始管理员账号密码 生产环境
#docker run -d -p 8001:8000 --name django-20171215 -v "$PWD":/usr/src/app -w /usr/src/app  --link mysql:mysql  -it 88e24e8c54a6  bash -c "python manage.py makemigrations && python manage.py migrate && python init_admin.py && /usr/local/bin/gunicorn --bind 0.0.0.0:8000 mysite.wsgi:application -w 2"
#开发环境
docker run -d -p 8001:8000 --name django-20171215 -v "$PWD":/usr/src/app -w /usr/src/app  --link mysql:mysql  -it 88e24e8c54a6  bash -c "python manage.py runserver 0.0.0.0:8000"


cd /home2/ryynet_docker/
docker run -d -p 80:80 -p 443:443 --name web -v "$PWD"/nginx.conf:/etc/nginx/nginx.conf:ro -v "$PWD"/logs:/var/log/nginx  -v "$PWD":/usr/share/nginx/html:ro -v /etc/localtime:/etc/localtime:ro  --link php5.6  --link django-jiahe  --link go-202003  -it nginx










