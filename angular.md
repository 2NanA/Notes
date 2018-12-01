**目录 (Table of Contents)**

[TOCM]

[TOC]


# AngularJS >>

###参考
>[实用技巧](http://blog.csdn.net/evankaka/article/details/51254021) 
>[过滤器](http://blog.csdn.net/bboyjoe/article/details/50455906) 
>[过滤器](http://blog.csdn.net/super_yang_android/article/details/51627905)
>[路由](http://blog.csdn.net/qq_20448859/article/details/51994455)
>[路由](https://blog.csdn.net/bing_javascript/article/details/51322842)
>[csdn angularjs教程](http://blog.csdn.net/column/details/learnangularjs.html)
>[directive](http://blog.csdn.net/DeepLies/article/details/52423490)
>[RouteProvider配置](https://blog.csdn.net/salmonellavaccine/article/details/37891717)

### Tips
- ng-app是一个特殊的指令，一个HTML文档只出现一次，如出现多次也只有第一个起作用；ng-app可以出现在html文档的任何一个元素上。
- ng-app作用：告诉子元素指令是属于angularJs。
- 使用 .directive 函数来添加自定义的指令。
- 使用驼峰法来命名一个指令， runoobDirective, 但在使用它时需要以 - 分割, runoob-directive:<runoob-directive></runoob-directive>
- ng-bind是从$scope -> view的单向绑定，也就是说ng-bind是相当于{{object.xxx}}，是用于展示数据的。
- ng-modle是$scope <-> view的双向绑定

##### angular config：
- 需要在AngularJS模块加载之前进行配置，就要用到config。只有(Provider)和常量(constant)才能注入到config中
- seivce定义的服务不能在config中使用
- ng启动阶段是 config-->run-->compile/link

### 资料
- [AngularJS 中文手册](http://www.angularjs.net.cn/api)
- [下载](https://github.com/angular/angular.js)
- [官方](https://code.angularjs.org)
- [报错](https://code.angularjs.org/1.4.6/docs/error/$controller/ctrlfmt?p0=)
- [angular.element方法汇总](https://blog.csdn.net/sinat_31057219/article/details/56676332)
- [AngularJS模块详解](https://blog.csdn.net/woxueliuyun/article/details/50962645)
- [英文API](http://docs.ngnice.com/api/ng)
- [视频教程](https://www.imooc.com/learn/156)
- [Angular UI 指令]







# Angular >>

### 设置cnpm
- `ng set --global packageManager=cnpm`
- `ng set --global warnings.packageDeprecation=false`

### 安装angular-cli:
- `cnpm install -g @angular/cli` 
- `npm install -g @angular/cli`
- `cnpm install -g angular-cli` （angular2.0 适配版）

>更新angular  
`Run npm i -g npm to update`

>带版本安装
`cnpm i --save angular-in-memory-web-api ^0.2.5`

> (会安装最新版本的angular cli 然后新建项目 会安装angular5 相关的module) 

> 如果你之前安装失败过，最好在安装angular-cli之前先卸载干净，用以下两句：

- `cnpm uninstall -g angular-cli`
- `cnpm cache clean`
- `cnpm cache verify`

##### 创建项目
- `ng new Myapp`

##### 启动项目
- `ng serve`
- `cnpm start`

#####改默认项目的端口
`ng serve --host 0.0.0.0 --port 4201 --live-reload-port`

### angular语法：

> 在多数场景下，推荐在 NgModule 的 Metadata 信息中配置相应的服务。 而不是在 单独的component组件中声明 providers: [HeroService]

##### @Injectable() 是必须的么？
- 如果所创建的服务不依赖于其他对象，是可以不用使用 Injectable 类装饰器。但当该服务需要在构造函数中注入依赖对象，就需要使用 Injectable 装饰器。
- 不过比较推荐的做法不管是否有依赖对象，在创建服务时都使用 Injectable 类装饰器。
- @Injectable()标志着一个类可以被一个注入器实例化

##### Angular Input & Output:

>Input相当于指令的值绑定，无论是单向的(@)还是双向的(=)。都是将父作用域的值“输入”到子作用域中，然后子作用域进行相关处理。

- 子组件定义Input变量(‘=’ 号左边的[]里面的变量)
- 父组件定义Input对应数据(‘=’ 号右边的的变量)

> Output相当于指令的方法绑定，子作用域触发事件执行响应函数，而响应函数方法体则位于父作用域中，相当于将事件“输出到”父作用域中，在父作用域中处理。

- 父组件页面
*app.component.html*
```html
<app-child [values]="data" (childEvent) = "getChildEvent($event)">
</app-child>
```
- 父组件
*app.component.ts*
```javascript
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  data = [1,2,3];

  getChildEvent(index){
    console.log(index);
    this.data.splice(index,1);
  }
}
```

- 子组件页面
*app-child.component.html*
```html
<p *ngFor="let item of values; let i = index" (click)="fireChildEvent(i)">
  {{item}}
</p>
```
- 子组件
*app-child.component.ts*
```javascript
@Component({
  selector: 'app-child',
  templateUrl: './child.component.html',
  styleUrls: ['./child.component.css']
})
export class ChildComponent implements OnInit {
  @Input() values;
  @Output() childEvent = new EventEmitter<any>();
  constructor() { }

  ngOnInit() {

  }
  fireChildEvent(index){
    this.childEvent.emit(index);
  }
}
```

##### 绑定：

- 展现component里面的数据

```javascript
<span>{{title}}</span>
export class BindComponent implements OnInit {
  title:string = "";
}
```

- 属性绑定
> 使用[属性]=“值”进行属性绑定(属性如果不加[],那么就直接是传统的赋值，加上[]就是angular中属性绑定)

```html
<p>2.属性绑定:</p>
<img src="{{src}}"/>
<p>3.属性绑定:</p>
<img [src]="src"/>
```
> bind.component.ts文件代码

```javascript
src:string = "http:::";
```

- 事件绑定
```html
<input type="button" value="按钮" (click)="info($event)"/>
```
> bind.component.ts文件代码
```javascript
info(event:any){
   console.log(event);
}
```

### Tips
- 查看版本的时候应该在angular根目录下 

### 常用ng命令
- ng new project-name - 创建一个新项目，置为默认设置
- ng build - 构建/编译应用
- ng test - 运行单元测试 (依赖 karma jasmine)
- ng e2e - 运行端到端（end-to-end）测试
- ng serve - 启动一个小型web服务器，用于托管应用
- ng deploy - 即开即用，部署到Github Pages或者Firebase
- ng generate component my-comp - 生成一个新组件，同时生成其测试规格和相应的HTML/CSS文件
- ng generate directive my-directive - 生成一个新指令
- ng generate pipe my-pipe - 生成一个新管道
- ng generate service my-service - 生成一个新服务
- ng generate route my-route - 生成一个新路由
- ng generate class my-class - 生成一个简易的模型类


### 参考 
- [属性绑定](http://blog.csdn.net/kuangshp128/article/details/71102049)
- [官方项目](https://angular.cn/tutorial) 
- [项目文件](http://blog.csdn.net/yuzhiqiang_1993/article/details/71191873 ) 
- [报错信息](https://www.cnblogs.com/xiaolonger/p/6518336.html) 
- [初级](https://angular.cn/guide/glossary) 
- [资料](http://blog.csdn.net/liangxw1/article/details/75267559) 
- [依赖注入](http://www.jb51.net/article/115317.htm) 
- [属性型指令](https://www.jianshu.com/p/c96676829f05)
- [directive & input & output](http://blog.csdn.net/shenlei19911210/article/details/53218074)
- [input & output子组件 父组件](http://blog.csdn.net/u014291497/article/details/60970792)
- [Angular中文社区](http://www.angularjs.cn/)
- [Angular博客](https://vsavkin.com/)
- [常见错误](https://segmentfault.com/a/1190000004969541)
- [ElementRef](https://segmentfault.com/a/1190000008653690)
- [语法快速指南](http://blog.csdn.net/shenlei19911210/article/details/53171370)
- [ViewChild与ContentChild](http://blog.csdn.net/bangrenzhuce/article/details/55051006)
- [Angular2 组件生命周期](https://www.cnblogs.com/SLchuck/p/5802308.html)
- [Angular2 资料大全](https://segmentfault.com/a/1190000008754631)(https://segmentfault.com/u/angular4)
- [Angular 版本变更](https://blog.csdn.net/u012620506/article/details/78008088)
- [component 元数据属性](https://blog.csdn.net/qq_33315185/article/details/64130064)
- [component 声明](https://www.jb51.net/article/136957.htm)
- [Angular 插件](https://segmentfault.com/a/1190000003858219)
- [组件和变化检测器](https://segmentfault.com/a/1190000008754052)
- [component tree 插件](https://github.com/rangle/augury)
- [angular常见问题](https://github.com/semlinker/angular-faq)
- [angular 静态文件](https://www.cnblogs.com/steven38-27/p/7851213.html)
- [angular restful](https://blog.csdn.net/chenjh213/article/details/72816337)

angular4教程网盘地址 ：http://pan.baidu.com/s/1jHYKEOm 密码：arfx
代码示例 https://www.cnblogs.com/seesharply/p/6219544.html



route
Observable Rxjs
phpdata
$http

type 类型
directive
动态组件
@Injectable()
所有工具
 



