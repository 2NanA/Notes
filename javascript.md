**目录 (Table of Contents)**

[TOCM]

[TOC]


# JavaScript >>

### 延迟加载
- window.onload <> ready or $(). 它是在所有模块加载完了才执行函数 ready 有延迟

### attribute & property
- Attribute属于HTML，可以是任意属性，赋值及取值使用setAttribute(); getAttribute()方法。
- Property属于DOM，赋值或取值使用.方式
- 非自定义attribute，如id、class、titile等，都会有对应的property映射
- 所以当我们编写HTML代码的时候，这些属性是可以在DOM上找到映射的，但是对于colspan这样的属性，DOM上没有对应的属性。
- 非自定义的property或attribute的变化多数是联动的。带有默认值的attribute不随property变化而变化。

##### 参考
[Click Me](http://joji.me/zh-cn/blog/html-attribute-vs-dom-property)

### attr() & prop() & val() 的区别
```html
<input type="text" value="123"/>
<button id="btn">click</button>
<script>

	$("#btn").click(function(){
		var attr=$("input").attr("value");
		var prop=$("input").prop("value");
		var val=$("input").val();
		console.log(attr);
		console.log(prop);
		console.log(val);
	})
</script>
```
> 代码如上所示，为输入框设定了初始值：123，此时点击按钮，控制台输出为：

1. attr：123
2. prop：123
3. val ：123

> 改变页面输入框的值为 123thgf ，此时控制台输出：

1. attr：123
2. prop：123thgf
3. val ：123thgf

> 如果我们没有为文本框设定初始值，即代码中删除value=”123”后，依旧使用如上js代码，则相应输出如下：

1. attr：undefined
2. prop：
3. val ：

> 输入页面value ‘asdasd’ 后：控制台输出为：

1. attr：undefined
2. prop：asdasd
3. val ：asdasd

> 可见，prop()和val()都能获取到文本框的实际value值，而attr()获取的则始终为文档结构中的value的属性值，与文本框实际值无关，并不会变化。

### HTML属性与DOM属性的区别
- DOM的本质就是JavaScript中的一个object。
- 对于浏览器引擎而言，并不存在“HTML标签”这回事。其本质是DOM节点对象。也并不存在“HTML文档”这回事；
- 其本质是DOM节点对象组成的文档树。浏览器引擎才是实际存储和渲染DOM节点对象的“大爷”。只是我们无法直接操作浏览器引擎，所以对这个本质并不熟悉；
- javascript中获取到的都是DOM元素，而不是HTML元素。
- 最终浏览器会解析HTML，构建DOM模型，也就是说浏览器会解析HTML元素为DOM元素。

### 模板字符串
```javascript
	$JS["onload"][] = '
		$("#unitList").live("DOMNodeInserted","tr",function(){
            if ($("#unitList tr:last-child").find("span").length == 0 && tmpDocwareLinkCheck != null && tmpDocwareLinkCheck != "") {
                var unitID = $("#unitList tr:last-child").find("input[type=hidden]").val();
				var docwareIconHtml = `<span title="${title}" class="tk-icon icon-tk-document" style="font-size: 18px;position: absolute;margin: 0 -30px;"
					onclick="popup('."'".'/sharp/docwarelinkpopup/index?isfromtablet=0&unitid=${unitID}&activitytype=${activitytype}&activityid=${activityid}'."'".',700,350);return false;" ></span>`;
                $("#unitList tr:last-child").find("input[type=checkbox]").before(docwareIconHtml);
            };
        });

		$("#unitList tr").each(function(){
			if (tmpDocwareLinkCheck != null && tmpDocwareLinkCheck != ""){
				var unitID = $(this).find("input[type=hidden]").val();
				var docwareIconHtml = `<span title="${title}" class="tk-icon icon-tk-document" style="font-size: 18px;position: absolute;margin: 0 -30px;"
					onclick="popup('."'".'/sharp/docwarelinkpopup/index?isfromtablet=0&unitid=${unitID}&activitytype=${activitytype}&activityid=${activityid}'."'".',700,350);return false;" ></span>`;
	            $(this).find("input[type=checkbox]").before(docwareIconHtml);
        	};
        });';
``` 

### Defaultvalue
``` javascript
<input type="text" value="Hello world">
const input = document.querySelector('input');

console.log(input.value);        // 'Hello world'

input.value = 'New value';

console.log(input.value);        // 'New value'
console.log(input.defaultValue); // 'Hello world'

``` 

### 图片转base64
``` javascript
function allImg2Base64() {
    var imgs = document.getElementsByTagName('img');
    for (var i = 0; i < imgs.length; i++) {
        img2Base64(imgs[i]);
    }
}

function img2Base64(img) {
    if (img.src.indexOf('data:image/') == 0) return ;
        var image = new Image();
        image.crossOrigin = "anonymous";
   image.onload = function (event) {
                    try {
                        var canvas = document.createElement("canvas");
                        canvas.width = image.width;
                        canvas.height = image.height;
                        var ctx = canvas.getContext("2d");
                        ctx.drawImage(image, 0, 0, image.width, image.height);
                        var dataURL = canvas.toDataURL();        
                        img.src = dataURL;
                    } catch (e) {
                        console.log(e);       
                    }
                };
                image.src = img.src;
            }
```       

### 参考
- [函数](http://hemin.cn/jq/prop.html)
- [jQuery](https://oscarotero.com/jquery/)
- [jQuery插件开发及jQuery.extend函数详解和jQuery.fn与jQuery.prototype区别](https://www.2cto.com/kf/201506/404398.html)
- [javascript中call()、apply()、bind()的用法](https://www.cnblogs.com/Shd-Study/archive/2017/03/16/6560808.html)
- [javascript字符串](http://www.jb51.net/article/74614.htm)
- [30s JS](http://www.css88.com/30-seconds-of-code/)
- [JQuery 插件库](http://www.jq22.com/jquery-info18210)
- [JQuery 文档](http://jquery.cuishifeng.cn/)
- [JQuery 中文文档](https://www.jquery123.com/)
- [JQuery API](http://www.css88.com/jqapi-1.9/)
- [JQuery 常用方法](http://blog.csdn.net/qq_33220449/article/details/52384936)
- [document对象概述](https://www.cnblogs.com/simonryan/p/4835294.html)
- [nextSibling和previousSibling使用注意事项](https://www.cnblogs.com/lijinwen/p/5690223.html)
- [XMLHttpRequest](https://segmentfault.com/a/1190000004322487)
- [XMLHttpRequest Level 2 使用指南](http://www.ruanyifeng.com/blog/2012/09/xmlhttprequest_level_2.html)
- [JSONP](https://blog.csdn.net/u013063153/article/details/52885744)
- [js跨域](http://www.jb51.net/article/77470.htm)
- [jsonp跨域](https://www.cnblogs.com/chiangchou/p/jsonp.html)
- [jQuery 处理XML](https://blog.csdn.net/csdn_yudong/article/details/52537609)
- [DOM 中 Property 和 Attribute 的区别](https://www.cnblogs.com/elcarim5efil/p/4698980.html)
- [Promise](https://www.cnblogs.com/lvdabao/p/jquery-deferred.html)
- [Promise 详解](https://blog.csdn.net/ssisse/article/details/52225252)
- [jQuery的deferred对象详解](http://www.ruanyifeng.com/blog/2011/08/a_detailed_explanation_of_jquery_deferred_object)
- [jquery.when() 原理](https://www.cnblogs.com/taoshengyijiuai/p/7834064.html)
- [原型链之prototype,__proto__以及constructor](https://blog.csdn.net/zhangliuxiaomin/article/details/54618626)
- [jQuery事件大全](https://blog.csdn.net/tanga842428/article/details/52432026)
- [js中__proto__和prototype的区别和关系](https://www.zhihu.com/question/34183746)
- [JavaScript prototype 面向对象](https://www.cnblogs.com/socool-hu/p/5665270.html)
- [JavaScript之Object原型方法](https://blog.csdn.net/hustzw07/article/details/75151528)
- [strict 模式](http://www.ruanyifeng.com/blog/2013/01/javascript_strict_mode.html)
- [廖雪峰javascript](https://www.liaoxuefeng.com/wiki/001434446689867b27157e896e74d51a89c25cc8b43bdb3000/0014345005399057070809cfaa347dfb7207900cfd116fb000)
- [火狐web技术文档](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object)
- [微软web技术文档](https://msdn.microsoft.com/library/kb6te8d3(v=vs.94).aspx)
- [显式 隐式 原型](https://www.cnblogs.com/wangfupeng1988/p/3979290.html)
- [instanceof 原理](https://www.ibm.com/developerworks/cn/web/1306_jiangjj_jsinstanceof/)
- [javascript API](https://www.w3cschool.cn/javascript/dict)
- [js symbol](https://blog.csdn.net/neweastsun/article/details/71309317)
- [冒泡](https://www.cnblogs.com/zhuzhenwei918/p/6139880.html)
- [前端论坛](https://www.w3ctech.com/topic/721)
- [promise book](https://github.com/liubin/promises-book/)
- [Jasmine](https://www.cnblogs.com/zhcncn/p/4330112.html)
- [object assign](https://blog.csdn.net/qq_30100043/article/details/53422657)
- [检查form表单数据是否发生变化](https://blog.csdn.net/u010933908/article/details/50790392)
- [a标签target](https://www.cnblogs.com/caojiayan/p/6149374.html)
- [深拷贝](https://www.cnblogs.com/penghuwan/p/7359026.html)
- [浅拷贝和深拷贝](https://www.cnblogs.com/Chen-XiaoJun/p/6217373.html)
- [浅拷贝和深拷贝](https://github.com/mqyqingfeng/Blog/issues/32)
- [oninput、onchange与onpropertychange](https://blog.csdn.net/freshlover/article/details/39050609)
- [javascript 15篇](https://juejin.im/post/59278e312f301e006c2e1510)
- [模板字符串](https://www.jb51.net/article/140326.htm)
- [标签模板函数](https://blog.csdn.net/blog_szhao/article/details/51792868)
- [arguments.callee](https://www.cnblogs.com/lijinwen/p/5727550.html)
- [JS 继承](https://www.cnblogs.com/humin/p/4556820.html)
- [JS eval](https://www.cnblogs.com/u-lhy/p/7062006.html)
- [JS 内存泄漏](https://blog.csdn.net/web_lc/article/details/72920029)(http://www.ruanyifeng.com/blog/2017/04/memory-leak.html)(https://www.cnblogs.com/libin-1/p/6013490.html)



# ECMAScript 6 >>

###语法
- let 允许创建块级作用域，ES6 推荐在函数中使用 let 定义变量，而非 var：
```javascript
let a = 3;
const ARR = [5,6];
```
if(parseFloat(element.value) > (parseFloat(element.defaultValue) + parseFloat(0.1)) || parseFloat(element.value) < ( parseFloat(element.defaultValue) - parseFloat(0.1) ) ){
                    requestData_isChanged[""+name] = true;
                }
                
###箭头函数
```javascript
var getPrice = function() {
	return 4.55;
};
//等同于：
var getPrice = () => 4.55;
```

>```javascript
.catch(err => console.log(err));  
```
等同于：
```javascript
catch(err){
	console.log(err);
} 
```

- =>左边是参数 右边是表达式
```javascript
let arr = ['apple', 'banana', 'orange'];
let breakfast = arr.map(fruit => {
	return fruit + 's';
});
console.log(breakfast); // apples bananas oranges
```

### Tips
- 现在已经不推荐使用arguments.callee()；原因：访问 arguments 是个很昂贵的操作，因为它是个很大的对象，每次递归调用时都需要重新创建。影响现代浏览器的性能，还会影响闭包。

###参考
[Click Here](https://www.cnblogs.com/hustskyking/p/a-kickstarter-guide-to-writing-es6.html) 
[浏览器支持](http://kangax.github.io/compat-table/es6/)
[ES6 API](http://es6.ruanyifeng.com/)


