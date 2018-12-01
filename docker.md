**目录 (Table of Contents)**

[TOCM]

[TOC]

# Docker >>

### 安装

- [toolbox](http://get.daocloud.io/#install-docker-for-mac-windows)
- [toolbox](http://mirrors.aliyun.com/docker-toolbox/windows/docker-toolbox/)
- [中文手册](http://www.docker.org.cn/page/resources.html)
- [博客](http://www.pangxie.space/)
- [主机](http://aws.amazon.com/cn/free/)

### 使用 no hyper v entered
默认装在C盘想装别的盘需要改变环境变量

### windows运行原理
- GO语言开发，运行依赖linux内核，无法直接在windows环境中直接运行Docker
- 使用docker-machine命令创建一个Docker虚拟机并附加到它上面。这个Docker虚拟机来为你的windows系统提供Docker服务

### 与linux的区别

在linux下面安装docker和在windows下面安装docker概念有所不同。

通常来讲，linux下面安装docker，你的机器既是localhost，同时也是docker主机。Docker的客户端
docker守候进程和容器都是直接运行在你的localhost机器上面的。
因为是在一台机器上，所以你可以使用localhost为你的docker容器做端口映射，比如：localhost:8000或者0.0.0.0:8000。

在window下面安装docker，docker的守候进程和容器是运行在linux虚拟机里面，docker命令则是运行在windows系统里面。
Docker主机的地址是linux虚拟机的地址，它被启动的时候，会分到一个ip地址。
当你启动一个容器的时候，容器的端口号会映射到虚拟机的一个端口号。

### 基础命令


#### 虚拟机管理
- `docker-machine ls`
- 创建 `docker-machine create --driver=virtualbox default`
- 获取环境变量 `docker-machine env default`
- 启动docker虚拟机 `docker-machine start default`
- 停止 `docker-machine stop`

#### 查看镜像
- `docker images`

#### 查看容器
- `docker images`

#### 修改虚拟机文件地址
- 默认情况下，docker-machine创建的虚拟机文件是保存在C盘的C:\Users\用户名\.docker\machine\machines\default 目录下的
- 如果下载和使用的镜像过多，那必然导致该文件夹膨胀过大

>
- [参考](https://www.cnblogs.com/studyzy/p/6113221.html)
- [Docker修改镜像存储位置](https://www.cnblogs.com/bchen/p/7691165.html)
- [创建docker虚拟机环境](https://blog.csdn.net/csdn_duomaomao/article/details/73274154)

#### 镜像加速
- 下载镜像 `docker pull mysql` 默认连接docker hub `docker pull tomcat`
- 删除镜像 `docker rmi imageid`  `docker system prune -a`
- 给Docker配置国内的加速地址

`docker-machine ssh default`
`sudo sed -i "s|EXTRA_ARGS='|EXTRA_ARGS='--registry-mirror=https://www.daocloud.io/mirror |g" /var/lib/boot2docker/profile`
`exit`
docker-machine restart default
 ps aux | grep docker
