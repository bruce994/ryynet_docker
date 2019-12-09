## 开发日志： ##
* 20181205  mysql容器增加中国时区 
* 20190524 nginx针对不同目录，配置不同php版本
* 20190719 php.ini 增加 max_input_vars = 3000 提交表单限制


# ** Docker php5.6 fpm  nginx  mysql 配置  **   #
#  操作说明 #
*  一、进入php_Dockerfile文件夹，运行 docker build -t php:5.6-fpm .  创建php:5.6-fpm镜像，这里包括了主要的组件如：zend gettext mysql mysqli opcache pdo_mysql sockets exif zip imagick等等（注意这里拉取国外镜像，推荐使用阿里云docker加速）
*  php5.6国内生成很慢，在这里我已经做好上传阿里云了，可以直接pull  (命令 docker pull registry.cn-hangzhou.aliyuncs.com/ryynet/php5.6:1.0)
* 二、在ryynet_docker目录下新建log  www  mysql  目录
* 三、直接执行./web_php_restart.sh 这样就会自动生成nginx、mysql容器，并且挂载日志目录log、网站目录www,数据库账号root,密码147258 (可以把该文件加入服务器启动项)
* 四、修改nginx配置文件，即可成功(注意，可以把不要的站点删除，结合自己的需求),把网站放在www目录下，这块根据自己需求设置


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
 django-1.11.7阿里云镜像 （docker pull registry.cn-hangzhou.aliyuncs.com/ryynet/django-1.11.7:1.0）
 django-2.0.6.2阿里云镜像 （docker pull registry.cn-hangzhou.aliyuncs.com/ryynet/django-2.0.6.2:1.0）


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




## docker 镜像如下： ##
```python
FROM django
MAINTAINER wang<1330407081@qq.com>
#COPY requirements.txt /usr/src/app/
RUN apt-get update &&  pip install Django==1.11.7 gunicorn==19.3.0  Pillow  django-tinymce  django-filebrowser  \
    && apt-get install -y \
    && apt-get install -y vim \
    && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
    && echo 'django.1.11.7 installed.'
```




