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



# 懒人营销平台功能介绍： #
### 1 日常功能
- 1.1 可管理多个订阅号、服务号查看每个号的粉丝情况（新关、取关、净增、总数等）
- 1.2 回复设置
- 1.3 参考公众后后台功能
- 1.4 菜单设置
- 1.5 参考公众号后台功能
- 1.6 粉丝管理
- 1.7 粉丝数据查看
   - 关注日期
   - 微信头像
   - 微信昵称
   - 微信openid
   - 用户地区
 - 1.8子账号流量管理

### 2 应用功能
##### 2.1 拉新海报（用户专属海报、助力海报）
- 2.1.1 支持模式
  - 支持关键字触发推送海报
  - 支持菜单点击触发推送海报
  - 支持H5网页点击触发推送海报
  - 支持多海报（活动）同时进行
- 2.1.2 数据查看
  - 活动列表数据
  - 每海报的拉新人数情况
  - 数量
  - 粉丝信息
  - 关注时间等
- 2.1.3 奖品设置
  - 实物奖品
  - 虚拟奖品
  - 兑换码
  - 有赞商品
- 2.1.4 海报设置
  - 活动时间配置
  - 关注设置
  - 强制开关
  - 新老粉丝设置
  - 各类提示语设置
  - 未开始
  - 暂停
  - 结束
  - 首次生成图片过程
  - 生成图片完成
  - 扫码关注提示语
  - 已关注
  - 未关注
  - 海报设计
  - 上传模板
  - 元素自定义（位置）
  - 头像
  - 形状
  - 昵称
  - 二维码
  - 实时预览

##### 2.2 投票
- 2.2.1 投票模式
  - 网页
  - 前端呈现
  - 活动首页
  - 报名页
  - 奖品页
  - 个人中心页
  - 后台自定义活动内容
  - 可自行设置活动海报、主题、规则等
  - 支持文字、图片、音视频播放
  - 强制关注
  - 参加、投票都需要关注
  - 用户信息获取
  - 用户可上传文字、图片、音视频
  - 用户报名时填写手机号、微信号等信息
  - 后台导出用户信息列表
  - 公众号信息提醒
  - 提醒用户已报名
  - 实时提醒用户好友为其投票
  - 投票方式多元化
  - 页面投票：点投票按钮
  - 公众号回复信息投票：例如向公众号回复TP1即给1号选手直接投票
  - 微信支付助力投票
  - 支付X元可为好友增加X票
  - 支付X元可减掉目标对手相应票数
  - 广告
  - 活动页插播商家广告
  - 支持点击图片或页面跳转至商家指定链接
  - 支持机器人刷票
  - 支付后台礼物管理员手动赠送

##### 2.3 拼团招生(分销模块)
- 2.3.1 发起活动
  - 管理活动增加、修改、删除
  - 设置红包金额、参与人数、时间等
- 2.3.2 报名管理
  - 导出数据数据
  - 搜索报名数据
  - 查看推广记录、付款状态
- 2.3.3 支付记录
  - 查看报名金额
- 2.3.4 红包记录
  - 查看红包记录(未发放、已发放、领取、24小时未领取退回)


##### 2.4 幸运九宫格(抽奖模块)
- 2.4.1 添加、修改、删除项目，奖品设置，抽奖规则设置
  - 抽奖记录
  - 中奖记录
  - 参与用户

##### 2.5 微信页面(单页内容模块)
- 添加页面
- 页面分类
- 页面文章

##### 2.6 微调研(报名表单模块)
- 调研记录
- 统计数据
- 可设置触发关键字，微信图文弹出

##### 2.7 微砍价(砍价模块)
- 砍价管理
- 单个活动可发起多个不同商品进行砍价
- 统计砍价记录，记录微信名称、头像、等信息
- 支付记录，查看记录情况
- 报名管理，可以收集砍价人的信息，免于发奖品

##### 2.8 微接力(接力模块)
- 发起活动
- 查看接力记录
- 接力名次排序
- 导出数据



