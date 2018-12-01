
Try minikube

在开发机（我用的是mac）上使用kubernetes，在此以记录。
安装minikube

这里选用minikubeminikube。

安装minikube前，需要安装一些虚拟机类的软件，我选用的的是virtualboxvirtualbox。下载安装即可。

然后就可以开始安装了。执行：


$ brew cask install minikube

等待片刻，应当就能自动安装完成。
然后就可以将其运行起来了：


$ minikube start

初次应当会自动下载一个镜像并且会自动运行起来，打开virtualbox应当可以看到一个running状态的虚拟机。
使用kubernetes

以上操作完成后，便可开始使用了，尝试执行


$ kubectl version

便可查看到Client Version和Server Version的相关消息，此后便可以正常使用了。

暂时先到这里
Share

    docker
    kubernetes
    minikube

2017-02-22
Try Hexo

第一次使用github.io，也是第一次使用hexo，感觉很nice，几分钟就有一个博客了。
创建仓库

我的是jupychen.github.io，pull到本地，开始造起来！
安装Hexo

这里用docker偷懒，写个Dockerfile。
内容是：


FROM node:latest
RUN npm install -g hexo
WORKDIR /app

build起来：


$ docker build -t myhexo .

加个alias，记得source一下：

alias hexo='docker run --rm -v $(pwd):/app -t myhexo hexo'

安装hexo-generator-feed

为了实现feed订阅功能，生成atom.xml，需要安装hexo-generator-feed。


docker run --rm -v $(pwd):/app -t myhexo npm install hexo-generator-feed --save

执行完上述命令，在node_modules文件夹下就可以看到hexo-generator-feed已经安装成功。

接着在_config.yml文件中添加：


plugin:
- hexo-generator-feed
feed:
type: atom
path: atom.xml
limit: 0
hub:
content:

有些主题自带feed的连接，没要的需要加上。（可以搜索主题的文档说明，feed连接是/atom.xml）。
开始写

新建一个文件夹blog， 在这里运行：


$ hexo init

噔噔噔，就有一个雏形了，再：


$ hexo new 'First Blog'

会发现./source/下多了一个md文件，然后就开始写作，写完运行一下：


$ hexo generate

就有了public文件夹。
修改文章

只需要修改./source/下的md文件，完成后运行：
	

$ hexo generate

就自动更新了public文件夹下的内容。
发布出去

把最开始pull下来的.git文件夹放到public文件夹中，用git提交到你的github仓库（jupychen.github.io）里面，然后打开jupychen.github.io，就能看到博客啦。
另外

如果想要有自己的域名，就在public文件夹里加个CNAME文件，写入自己的域名，并将该域名CNAME解析到jupychen.github.io。

打开jupychen.mymark.top

就酱！










Try Hexo

第一次使用github.io，也是第一次使用hexo，感觉很nice，几分钟就有一个博客了。
创建仓库

我的是jupychen.github.io，pull到本地，开始造起来！
安装Hexo

这里用docker偷懒，写个Dockerfile。
内容是：

1
2
3

	

FROM node:latest
RUN npm install -g hexo
WORKDIR /app

build起来：

1

	

$ docker build -t myhexo .

加个alias，记得source一下：

1

	

alias hexo='docker run --rm -v $(pwd):/app -t myhexo hexo'

安装hexo-generator-feed

为了实现feed订阅功能，生成atom.xml，需要安装hexo-generator-feed。

1

	

docker run --rm -v $(pwd):/app -t myhexo npm install hexo-generator-feed --save

执行完上述命令，在node_modules文件夹下就可以看到hexo-generator-feed已经安装成功。

接着在_config.yml文件中添加：

1
2
3
4
5
6
7
8

	

plugin:
- hexo-generator-feed
feed:
type: atom
path: atom.xml
limit: 0
hub:
content:

有些主题自带feed的连接，没要的需要加上。（可以搜索主题的文档说明，feed连接是/atom.xml）。
开始写

新建一个文件夹blog， 在这里运行：

1

	

$ hexo init

噔噔噔，就有一个雏形了，再：

1

	

$ hexo new 'First Blog'

会发现./source/下多了一个md文件，然后就开始写作，写完运行一下：

1

	

$ hexo generate

就有了public文件夹。
修改文章

只需要修改./source/下的md文件，完成后运行：

1

	

$ hexo generate

就自动更新了public文件夹下的内容。
发布出去

把最开始pull下来的.git文件夹放到public文件夹中，用git提交到你的github仓库（jupychen.github.io）里面，然后打开jupychen.github.io，就能看到博客啦。
另外

如果想要有自己的域名，就在public文件夹里加个CNAME文件，写入自己的域名，并将该域名CNAME解析到jupychen.github.io。

打开jupychen.mymark.top

就酱！
