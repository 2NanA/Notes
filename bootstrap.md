```
<!DOCTYPE html>
<html lang="zh-CN">
  ...
</html>
```

## 移动设备优先
```
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
```

##　尺寸
xs <768px
sm ≥768px
md ≥992px
lg ≥1200px

## 容器
> div.container

.container-fluid 类用于 100% 宽度，占据全部视口（viewport）的容器。
> div.container-fluid


## 栅格系统
> div.row > div.col-[xs|sm|md|lg]-[1-12|min|max]

## 流式布局容器
> div.container-fluid > div.row

## Add the extra clearfix for only the required viewport
> div.clearfix.visible-xs-block

## 列偏移
> div.col-[xs|sm|md|lg]-offset-[1-12|min|max]

## 标题
> h1-h6
> small .small

## 段落突出显示。
> p.lead
mark del s ins u strong em b i 

> p.text-left
> p.text-center
> p.text-right
> p.text-justify
> p.text-nowrap

## 改变大小写
> p.text-lowercase
> p.text-uppercase
> p.text-capitalize

## 缩略语
```
<abbr title="attribute">attr</abbr>
<abbr title="HyperText Markup Language" class="initialism">HTML</abbr>
```

地址
```
<address>
  <strong>Twitter, Inc.</strong><br>
  1355 Market Street, Suite 900<br>
  San Francisco, CA 94103<br>
  <abbr title="Phone">P:</abbr> (123) 456-7890
</address>

<address>
  <strong>Full Name</strong><br>
  <a href="mailto:#">first.last@example.com</a>
</address>
```

## 引用
blockquote footer cite
```
<blockquote class="blockquote-reverse">
  ...
</blockquote>
```

## 列表

## 无样式列表
> ul.list-unstyled

## 内联列表
> ul.list-inline

> dl.dl-horizontal
## 自动截断
通过 text-overflow 属性，水平排列的描述列表将会截断左侧太长的短语。在较窄的视口（viewport）内，列表将变为默认堆叠排列的布局方式。

## 代码
## 内联代码
code kbd pre var samp

## 表格
> table.table

## 斑马条纹样式
不被 Internet Explorer 8 支持
> table.table.table-striped

## 带边框的表格
> table.table.table-bordered

## 鼠标悬停
> table.table.table-hover

## 紧缩表格
> table.table.table-condensed


## 状态类
> [tr|td|th].active     鼠标悬停在行或单元格上时所设置的颜色
> [tr|td|th].success    标识成功或积极的动作
> [tr|td|th].info   标识普通的提示信息或动作
> [tr|td|th].warning    标识警告或需要用户注意
> [tr|td|th].danger     标识危险或潜在的带来负面影响的动作

## 响应式表格
> table.table-responsive

## 表单
> .form-group > input.form-control.input-lg|sm

> form > div.form-group > input.form-control
> form > div.checkbox > input[type="checkbox"]

> form > div.form-group > div.input-group > div.input-group-addon + input.form-control + div.input-group-addon


## 水平排列的表单
> form.form-horizontal > div.form-group > div.col-sm-10 > input.form-control

## INPUT TYPE
> text、password、datetime、datetime-local、date、month、time、week、number、email、url、search、tel 和 color。
 
## 多选和单选框
> div.checkbox.disabled
> div.radio

## 内联单选和多选框
> label.checkbox-inline > input
> label.radio-inline > input
> div.checkbox > label > input[type="checkbox|radio"]

## SELECT
> select.form-control
```
<select multiple class="form-control"></select>
```
## 静态控件
> p.form-control-static

## 焦点状态
> :focus
> not-allowed
> disabled

## 被禁用的 fieldset
> <fieldset disabled>
a标签!

## 只读状态
> readonly

## Help text
> input.form-control[aria-describedby="helpBlock"] + span.help-block#helpBlock

## 校验状态
> .has-warning|.has-error|.has-success 添加到控件的父元素
> .control-label、.form-control 和 .help-block 元素将接受这些校验状态的样式


## 添加额外的图标
.has-feedback 添加到控件的父元素
只能使用在文本输入框 <input class="form-control"> 元素上

## 图标、label 和输入控件组
> div.has-feedback > <span class="glyphicon glyphicon-ok form-control-feedback" aria-hidden="true">

## 控件尺寸
> :input.form-control.input-lg|sm

## 水平排列的表单组的尺寸
通过添加 .form-group-lg 或 .form-group-sm 类，为 .form-horizontal 包裹的 label 元素和表单控件快速设置尺寸。
> form.form-horizontal > div.form-group.form-group-lg

## 按钮
a button input
> .btn> .btn-default
> .btn-default
> .btn-primary
> .btn-success
> .btn-info
> .btn-warning
> .btn-danger
> .btn-link

> .btn-lg
> .btn-sm
> .btn-xs

> .btn-block

> .active

> [aria-pressed="true"]

## 禁用状态
> .disabled
> a[role="button"] ?

## 响应式图片
> img.img-responsive

## 图片形状
> img.img-rounded
> img.img-circle
> img.img-thumbnail

## 辅助类
> p.text-muted
> p.text-primary
> p.text-success
> p.text-info
> p.text-warning
> p.text-danger

## 处理差异
> p.bg-primary
> p.bg-success
> p.bg-info
> p.bg-warning
> p.bg-danger




## 关闭按钮
```
<button type="button" class="close" aria-label="Close"><span[aria-hidden="true"]>&times;</span></button>
```
## 三角符号
> <span class="caret"></span>

## 快速浮动

## 通过添加一个类，可以将任意元素向左或向右浮动。!important 被用来明确 CSS 样式的优先级。这些类还可以作为 mixin（参见 less 文档） 使用。

> div.pull-left
> div.pull-right


## 清除浮动
父元素
> div.clearfix

## 显示或隐藏内容
> .show
> .hidden
> .invisible

> .visible-xs-[block|inline|inline-block]
> .visible-sm-*
> .visible-md-*
> .visible-lg-*
> .hidden-xs
> .hidden-sm
> .hidden-md
> .hidden-lg


## 打印类
> .[visible|hidden]-print-[block|inline|inline-block]

## 屏幕阅读器和键盘导航
> .sr-only.sr-only-focusable
供视觉障碍者的 screen reader 使用
