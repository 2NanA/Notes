**目录 (Table of Contents)**

[TOCM]

[TOC]



# PHP >>

### 错误处理
```php
ini_set('error_display',1);
preg_match();  // php7 正则匹配
```  

- 打开错误报告：
```php
error_reporting(E_ALL); // 用,连接字符比.效率高
```    

### Composer
[命令](http://docs.phpcomposer.com)
- composer remove phpexcel/phpexcel 当前文件夹下删除安装过的包

### 测试
- "phpbenchmark/phpbenchmark": "1.1.4"
- Yaf是用PHP扩展的形式写的一个PHP框架，也就是以C语言的编写，性能上要比PHP代码写的框架要快一个数量级

> [参考](http://www.phpbench.com/)
> [phpspec](http://www.phpspec.net/en/stable/manual/introduction.html)
> [git](https://github.com/victorjonsson/PHP-Benchmark)

### 命令行
- php -S 0.0.0.0:3000 外部可以通过IP地址访问

### PHP Parser
- [项目](https://github.com/nikic/PHP-Parser)

### PHP Xdebug
- []()

### 反射
``` php
echo "<pre>";
$ref = new \ReflectionClass($this->protectedDB);
var_dump($ref->getMethods()); 
var_dump($ref->getFileName()); 
die;
```

### Tips
- file_get_content 和 curl 的区别 主要是curl 会做dns缓存 ，减少了dns查询的开销时间 （回家搜索）
  - curl多用于互联网网页之间的抓取，fopen多用于读取文件，而file_get_contents多用于获取静态页面的内容。
  - fopen /file_get_contents 每次请求都会重新做DNS查询，并不对DNS信息进行缓存。但是CURL会自动对DNS信息进行缓存。对同一域名下的网页或者图片的请求只需要一次DNS查询。这大大减少了DNS查询的次数。所以CURL的性能比fopen /file_get_contents 好很多。
  - fopen /file_get_contents在请求HTTP时，使用的是http_fopen_wrapper，不会keeplive。而curl却可以。这样在多次请求多个链接时，curl效率会好一些。
  - curl可以模拟多种请求，例如：POST数据，表单提交等，用户可以按照自己的需求来定制请求。而fopen / file_get_contents只能使用get方式获取数据。
- 商城订单超过 30 分钟未支付自动取消订单
  - 创建订单的时候 创建一个 30 分钟后执行的异步任务 如果支付成功取消这个任务 如果没有支付 就会自动执行
  - 轮询取消任务 1分钟执行一次
  - 做定时任务，同时每次访问该数据的时候也判断一下 是否超出支付时间
  - 订单失败，是会给用户发邮件的 订单支付超时商品回库的问题
  - [实现](https://github.com/ouqiang/delay-queue)
- 装了一个新的扩展 或者引用了一个新的dll 的时候，重启apache 相当于重新编译了一遍php （错误）
- PHP 以前的版本有扩展 apc，apc缓存分为系统缓存和用户缓存。
- php5.5以后，opcache将代替apc做为php加速的位置，也就是代替其系统缓存的位置。
- 用户缓存功能独立出来，开启新的组件，这个组件名称叫做apcu。 所以这两个扩展不冲突。


### easywechat 

### 基础
- [global 关键字](https://www.cnblogs.com/Life-Record/p/4964344.html)
- [htmlentity](https://blog.csdn.net/zhuizhuziwo/article/details/50623014)
- [string 格式化](https://www.cnblogs.com/bushuo/p/5657730.html)
- [sprintf](https://www.cnblogs.com/phpper/p/7546054.html)
- [清除缓存](https://blog.csdn.net/jackyrongvip/article/details/9218065)
- [什么时候使用fflush函数](https://blog.csdn.net/daiyan_csdn/article/details/51620472)
- [filetype](https://www.cnblogs.com/ncong/p/3953219.html)
- [文件锁](https://blog.csdn.net/fdipzone/article/details/43839851)
- [缓存](https://blog.csdn.net/dyzhen/article/details/8973168)
- [header](https://blog.csdn.net/u010714784/article/details/54406310)
- [PHP使用header方式实现文件下载](http://www.cnblogs.com/chenpingzhao/p/7768584.html)
- [php中的&引用的用法解析](https://blog.csdn.net/alen_xiaoxin/article/details/56011299)
- [SPL 自动加载](https://blog.csdn.net/gavin_new/article/details/52805811)
- [魔术方法](http://www.jb51.net/article/96167.htm)
- [do while嵌套](https://blog.csdn.net/this_capslock/article/details/41843371)
- [windows php 扩展安装包](http://windows.php.net/downloads/pecl/releases/apcu/5.1.8/php_apcu-5.1.8-7.1-ts-vc14-x64.zip)
- [php bug list](https://bugs.php.net/search.php?limit=30&order_by=id&direction=DESC&cmd=display&status=Open&bug_type=All)

### 参考
- [PHP社区](http://www.php1.cn/detail/10_GeZhiDeShenSi_c3e8a038.html)
- [PHP Output Controle](http://www.uedsc.com/php-output_buffering.html)
- [PHP Output Buffer setting](https://www.cnblogs.com/webzhuo/articles/4142700.html)
- [PHP ob_flush](http://blog.csdn.net/huyanping/article/details/7565662)
- [PHP 文件](https://www.cnblogs.com/penghuwan/p/6884932.html)
- [php7 新特xing](http://blog.csdn.net/h330531987/article/details/74364681)
- [php7 yield](http://blog.csdn.net/qq_20329253/article/details/52202811)
- [php7 协程](http://www.laruence.com/2015/05/28/3038.html)
- [curl 封装](https://github.com/php-curl-class/php-curl-class)
- [php文章](http://blog.jobbole.com/tag/php/)
- [phpweb 开发](http://www.admin10000.com/php/)
- [php站中文网](http://www.php-z.com/)
- [Session](https://blog.csdn.net/hai_qing_xu_kong/article/details/52262182)
- [php 推荐2017 年 PHP 程序员未来路在何方](http://blog.jobbole.com/110590/)
- [zend 官方手册](http://www.php100.com/manual/ZendFramework/)
- [tcpdf](https://tcpdf.org/examples/)
- [微信小程序](http://www.php.cn/xiaochengxu-351287.html)
- [php微信公众号开发](http://www.php.cn/course/851.html)
- [详解微信小程序](http://www.php.cn/xiaochengxu-355024.html)
- [Heredoc定界符](https://blog.csdn.net/u013372487/article/details/51883177)
- [weixin](https://developers.weixin.qq.com/miniprogram/dev/framework/view/wxml/)
- [clousure](https://blog.csdn.net/lc900730/article/details/74892806)
- [clousure 例子](https://www.cnblogs.com/lizhi-/articles/7204146.html)
- [PHP Trait](https://segmentfault.com/a/1190000002970128)
- [PHP 命令行](https://www.cnblogs.com/myjavawork/articles/1869205.html)
- [php filter_var](https://blog.csdn.net/972301/article/details/52530760)
- [HTTP消息头](https://www.cnblogs.com/honghong87/articles/6941436.html)
- [PHP获取AUTHORIZATION认证验证](https://blog.csdn.net/baidu_28393027/article/details/82888299)
- [http authorization 基本认证](https://www.cnblogs.com/chenrong/articles/5818498.html)
- [php 路线](https://segmentfault.com/a/1190000015882133)
- [php-fpm fastCGI](https://blog.csdn.net/QFire/article/details/78680717?locationNum=1&fps=1)
- [guzzle 中文文档](https://guzzle-cn.readthedocs.io/zh_CN/latest/)
- [composer package list](https://packagist.org/packages/phpoffice/phpword)
- [基于token的身份验证](https://www.jianshu.com/p/97c193ee1a09)
- [easywechat](https://www.easywechat.com/docs/master/overview)
- [php 闭包](http://www.cnblogs.com/XGHeaven/p/4245306.html)
- [框架笔记](https://www.v2ex.com/t/396191#reply28)
- [面试总结](https://coffeephp.com/articles/4?utm_source=v2ex)
- [OAuth 官网](https://oauth.net/code/)
- [理解oAuth](http://www.ruanyifeng.com/blog/2014/05/oauth_2_0.html)
- [OAuth 2.0 协议](https://www.cnblogs.com/hyl8218/p/3584505.html)
- [PDO 不能完全防止SQL注入](https://stackoverflow.com/questions/134099/are-pdo-prepared-statements-sufficient-to-prevent-sql-injection/12202218#12202218)
- [php-fpm](https://blog.csdn.net/u010785091/article/details/78705690)
- [apcu简介](https://blog.csdn.net/qq_37699037/article/details/80586946)
- [PHP安装包TS和NTS的区别](https://blog.csdn.net/zhuifengshenku/article/details/38796555)
- [APCu 和 memcahed的区别](http://log4geek.cc/2017/03/php%e9%ab%98%e7%ba%a7%e6%8a%80%e8%83%bd%e4%b9%8bphp%e7%bc%93%e5%ad%98/)
- [composer命令介绍之install和update及其区别](https://blog.csdn.net/qq_28787211/article/details/79357879)
- [php 爬虫博客](https://www.v2ex.com/member/gouchaoer)
- [php cgi fpm的解释](https://www.cnblogs.com/f-ck-need-u/p/7627035.html)
- [php的几种运行模式CLI、CGI、FastCGI、mod_php](https://www.cnblogs.com/orlion/p/5282753.html)
- [深入理解ob_flush和flush的区别](http://www.laruence.com/2010/04/15/1414.html)
- [PDO bindParam的一个陷阱](http://www.laruence.com/2012/10/16/2831.html)
- [PHP OPcache](https://laravelacademy.org/post/7326.html)
- [安装 OPcache](https://www.cnblogs.com/GaZeon/p/7106574.html)
- [PHP opcode yuanl](https://www.cnblogs.com/lamp01/p/8985068.html)
- [开启 OPcache 注意事项](https://blog.csdn.net/mengzuchao/article/details/81751257)
- [opcode list](http://www.laruence.com/2008/11/20/640.html)
- [php iterator](https://segmentfault.com/a/1190000010218596)
- [php 双链表](https://blog.csdn.net/wuxing26jiayou/article/details/51862707)
- [php 链表详解](https://blog.csdn.net/a5582ddff/article/details/77769405)
- [PHP SPL 使用](https://blog.csdn.net/ivan820819/article/details/49465803)

https://github.com/mk-j/PHP_XLSXWriter

面向对象
dns 解析
https://github.com/symfony/symfony/tree/master/src/Symfony/Component

https://github.com/doctrine/doctrine2/tree/master/lib/Doctrine/ORM

开发
https://www.v2ex.com/t/461502#reply33

https://github.com/lostab/tumgor


https://www.v2ex.com/t/341617#reply19 redis
PHP 视频教程网站
https://phpcasts.org/

# Swoole >>
- [官网](https://www.swoole.com/)
- [初级教程](https://github.com/LinkedDestiny/swoole-doc)
- [文档](https://wiki.swoole.com/wiki/page/1.html)





# WordPress >>

### 安装
- [github](https://github.com/search?l=PHP&q=wordpress&type=Repositories&utf8=%E2%9C%93)

### 资源
- [官方](https://codex.wordpress.org/zh-cn:Main_Page)
- [中文网](http://wpchina.org/)
- [API](https://developer.wordpress.org/reference/) 
- [插件API](https://codex.wordpress.org/zh-cn:%E6%8F%92%E4%BB%B6_API)
- [基础 使用](http://www.diyzhan.com/2014/02/wordpress-admin-panel/)
- [视频](https://www.wpdaxue.com/develop/)
- [二次开发](https://www.cnblogs.com/gaotianpu/p/wordpress.html)
- [自定义主题](https://www.ludou.org/create-wordpress-themes-prepare.html)
- [wordpress shortcode](https://9iphp.com/opensystem/wordpress/1094.html)

### 主题和插件

- 文件夹：wp-content\plugins 
- 插件调用  wp-admin/includes/plugin.php
- 搜索wp内置方法




# Yii >>

### Tips
- session start设置文件位置在php ini设置
- models \yii\validators\Validator::$builtInValidators
- BaseObject.php 内置getter setter 有些类继承之后可以调用未定义属性 yii\data\Pagination
- 隐式调用 yii\db\ActiveQuery => yii\db\Query  实现 QueryInterface 和 ExpressionInterface

  QueryInterface 定义了抽象方法 andFilterWhere  在 yii\db\Query 内部 use QueryTrait; 调用到了 andFilterWhere方法
  
  以下是构建sql 的过程
  - yii\db\Query createCommand方法 $db = Yii::$app->getDb();  $db->getQueryBuilder()->build($this)  ["getQueryBuilder" "yii\db\Connection"]  ($this 是 ExpressionInterface对象)  
  - yii\db\Connection:  $this->getSchema()->getQueryBuilder(); [$this->getSchema()] => yii\db\mysql\Schema
  - yii\db\abstract class Schema  => getQueryBuilder() => $this->createQueryBuilder() => new QueryBuilder($this->db);
  - yii\db\mysql\QueryBuilder  => \yii\db\QueryBuilder   (代码调用主文件)
  
- yii\grid\GridView widget => yii\base\Widget.php widget() => yii\widgets\BaseListView.php run() => yii\grid\GridView renderItems() 渲染画面 ：
  - yii\grid\DataColumn => renderHeaderCell()   => yii\data\Sort
  - dataProvider
  - filterModel
  
### Refer
- [Form](http://www.kuitao8.com/20150321/3638.shtml)











# Laravel >>

### 配置
- 路由
- blade模板
- 数据库迁移 ： 运行php artisan migrate之前请检查你的.env文件中DB_DATABASE，DB_USERNAME，DB_PASSWORD 几项配置是否正确
- artisan
- .env
- controller middleware Illuminate\Routing\Controller.php Illuminate\Routing\ControllerMiddlewareOptions 主要有middleware 方法
- php artisan 显示全部可用命令
- php artisan migrate:rollback 运行的是migration 文件里的down 方法 回滚上一次的动作
- 修改表字段，应该生成一个新的migration文件
- \Illuminate\Support\helpers.php \Illuminate\Foundation\helpers.php 自带函数路径
- eval(\Psy\sh()); 断点
- \laravel\blog\vendor\psy\psysh\src\Psy\functions.php 定义方法的文件
- \Illuminate\Database\Schema\Blueprint.php \Illuminate\Support\Fluent.php migrations 相关文件
- `php artisan migrate --seed` to create and populate tables php artisan migrate:refresh --seed
- @stop 和 @endsection 同理
- config/app.php 有blade模板中 HTML 类的配置 app('html') 返回一个对象 -> 配置在config/app里面的
- config/app.php 加入新的api aliases配置数组里面定义了引用类的别名。使用方法是在别名前加一个反斜杠，例如：\App::basePath();
- link_to vendor\laravelcollective\html\src\helpers.php 自带函数
- session 方法在 src\Illuminate\Foundation\helpers.php
- Request::is \Illuminate\Http\Request.php          Request -> Illuminate\Foundation\Validation\ValidatesRequests.php validate方法
- Request Illuminate\Validation\Validator.php 验证规则的定义  extends   \Illuminate\Contracts\Validation\Validator, (第一个是实际调用的文件)
- Request rules方法
- 服务注册 Illuminate\Support\ServiceProvider.php
- Response symfony\http-foundation\Response.php
- Model：Illuminate\Database\Eloquent\Builder.php  数据库操作where orderBy take get  
- uuid composer require webpatser/laravel-uuid
- CSRF Illuminate\Foundation\Http\Middleware\VerifyCsrfToken.php
- Auth  * @see \Illuminate\Auth\AuthManager \Illuminate\Contracts\Auth\Factory  \Illuminate\Contracts\Auth\Guard  \Illuminate\Contracts\Auth\StatefulGuard
- Auth::routes() =>  static::$app->make('router')->auth(); =>   Illuminate\Routing\Router.php 里面有登录模块的路由   还有resource
- Auth controller 里面有use 了一些相关的文件 Illuminate\Foundation\Auth\AuthenticatesUsers.php  show login 页面等方法
- 中间件配置在app\Http\Kernel.php
- HTML Form : \laravelcollective\html\src\FormBuilder.php
- Route::resource('users', 'UsersController');
上面代码将等同于：
  - Route::get('/users', 'UsersController@index')->name('users.index');
  - Route::get('/users/{user}', 'UsersController@show')->name('users.show');
  - Route::get('/users/create', 'UsersController@create')->name('users.create');
  - Route::post('/users', 'UsersController@store')->name('users.store');
  - Route::get('/users/{user}/edit', 'UsersController@edit')->name('users.edit');
  - Route::patch('/users/{user}', 'UsersController@update')->name('users.update');
  - Route::delete('/users/{user}', 'UsersController@destroy')->name('users.destroy');

### 开发
- 首先，创建相关路由：app/Http/routes.php
- 然后，使用 artisan 创建控制器：
- 打开控制器，创建相应方法：
- 然后，在 resources/views 目录下创建对应的视图文件 home.blade.php和about.blade.php
- [步骤](https://blog.csdn.net/u014665013/article/details/77801111)

### 初始化
- public/index.php 文件是所有对 Laravel 应用程序的请求的入口点
- index.php 文件加载 Composer 生成定义的自动加载器，然后从 bootstrap/app.php 脚本中检索 Laravel 应用程序的实例。
Laravel 本身采取的第一个动作是创建一个 application/ service container 的实例。真正的实例是Illuminate\Foundation\Http\Kernel \Illuminate\Foundation\Application.php
- app() xiangjie

### Laravel 5.5 中文文档
- [Click Here](https://www.v2ex.com/t/389697#reply5)
- [自定义内置函数](http://laravelacademy.org/post/205.html#ipt_kb_toc_205_59)
- [中文社区](https://laravel-china.org/)
- [golaravel](http://www.golaravel.com/)
- [artisan 使用](https://blog.csdn.net/aaroun/article/details/79140618)
- [实验楼基础项目](https://www.shiyanlou.com/courses/running)
- [视频](https://www.imooc.com/learn/702)
- [laravel5 数据库配置](https://blog.csdn.net/zjiang1994/article/details/52600135)
- [资料汇总](https://github.com/chiraggude/awesome-laravel)
- [starter](https://github.com/bestmomo/laravel5-example)
- [blade 组件插槽](https://segmentfault.com/a/1190000010864876)
- [PsySH](http://blog.jobbole.com/99110/)
- [trans 多语言](https://blog.csdn.net/iong_l/article/details/69397586)(https://www.cnblogs.com/redirect/p/7457024.html)
- [laravel IOC](https://www.cnblogs.com/lpfuture/p/5578274.html)
- [auth 认证](https://blog.csdn.net/realghost/article/details/52558962)
- [laravel config](https://www.jianshu.com/u/3275508ab630)
- [laravel request中rules规则大全](https://blog.csdn.net/qq_35641923/article/details/79174555)(https://laravel-china.org/docs/laravel/5.3/validation/1167)
- [laravel repository](https://www.cnblogs.com/Stone--world/p/4756043.html)
- [laravel 5.1 LTS 速查](https://cs.laravel-china.org/)
- [仓库模式](https://www.cnblogs.com/xiaoqian1993/p/6207476.html)
- [migration](https://blog.csdn.net/u013230444/article/details/70226161)(https://blog.sbot.io/articles/12)
- [laravel 50tips](https://www.cnblogs.com/wuoshiwzm/p/6086164.html)
- [uuid](https://blog.csdn.net/yang_yun_hao/article/details/81540221)
- [laravel eloquent whereX](https://www.cnblogs.com/summerblue/p/8871999.html)
- [laravel知识点](http://www.itdaan.com/blog/2016/04/08/7662fbf52970cd3d7dfcc0447e40e9cc.html)
- [PHP 安全 过滤、验证和转义](https://laravelacademy.org/post/4610.html)
- [laravel collective](https://laravelcollective.com/docs/5.2/html#form-model-binding)
- [blade 双感叹号](https://blog.csdn.net/u014665013/article/details/77801111)
- [laravel 分页](https://www.cnblogs.com/timeismoney/p/7082444.html)
- [laravel csrf 原理](https://www.cnblogs.com/GBWSHUSHU/p/6957324.html)
- [laravel carbon](https://blog.csdn.net/gengfu_php/article/details/78307950)
- [carbon 官方文档](https://carbon.nesbot.com/)
- [php benchmark](http://www.phpbenchmarks.com/en/comparator/compare.html?components=zend-framework-3.0%7Esymfony-4.0%7Esymfony-3.4%7Esymfony-2.8%7Elaravel-5.5%7Elaravel-5.4&benchmarkType=all&benchmarkTools=apache-bench&phpVersions=php-7.1%7Ephp-7.2%7Ephp-7.0&concurrencies=)
- [laravel 路由解析](https://segmentfault.com/a/1190000008886761)
- [laravel route https](https://www.e-learn.cn/content/wangluowenzhang/20309)
- [laravel 5.4后台](https://www.v2ex.com/t/346658#reply18)
- [laravel 视频](https://www.codecasts.com/lessons)

### 实例
- [基于 Laravel 开发的在线点播系统 MeEdu](https://www.v2ex.com/t/494019#reply49)
- [网页截图](https://www.v2ex.com/t/483447#reply23)
- []()


Apache canshu 




# Symphony >>

### 安装
`composer create-project symfony/framework-standard-edition mysampleproject/ 2.6.0`

> 如果你的网络连接很慢，你可能会认为Composer没有做任何事。这时，请在前述命令中添加-vvv旗标，以输出Composer正在做的每一件事的细节。 
安装好之后 php app/console server:run

### 文档
- [官方](http://www.symfonychina.com/doc/current/setup.html)




