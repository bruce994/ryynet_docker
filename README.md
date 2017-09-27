# ** Docker php5.6 fpm  nginx  mysql 配置  **   #
#  操作说明 #
*  一、进入php_Dockerfile文件夹，运行 docker build -t php:5.6-fpm .  创建php:5.6-fpm镜像，这里包括了主要的组件如：zend gettext mysql mysqli opcache pdo_mysql sockets exif zip imagick等等（注意这里拉取国外镜像，推荐使用阿里云docker加速）
* 二、直接执行./web_php_restart.sh 这样就会自动生成nginx、mysql容器，并且挂载日志目录log、网站目录www (可以把该文件加入服务器启动项)
* 三、修改nginx配置文件，即可成功(注意，可以把不要的站点删除，结合自己的需求)
