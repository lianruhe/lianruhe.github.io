---
title: questions
category: 学习笔记
date: 2018-02-23 16:55:31
tags: 前端问题
---

总结一些前端方面的知识点

# node 相关

## require的原理及执行过程
> 首先从缓存中读取，没有的话需要加载文件；根据参数来确定文件路径（传入的是绝对路径还是相对路径，路径格式，是／还是文件名结尾，是否需要加 index.js 等）；然后就是加载文件，不同格式要用不同的解析，如：js 要进行编译，json要用 JSON.parse 解析等；加载 js 文件是在 js 文件用函数包装，传入 exports，require 等参数；

## OSI 七层模型
> OSI（Open System Interconnection）开放系统互连参考模型，是ISO制定的一个用于计算机或通信系统间互联的标准体系，它是一个七层抽象模型，从低到高分别是：物理层、数据链路层、网络层、传输层、会话层、表示层和应用层。目的是为不同计算机互连提供一个共同的基础和标准框架，OSI中包括一系列抽象的术语、概念，也包括具体的协议，遵循OSI参考模型和相关协议能够实现计算机或通信系统间互联互通。

## 模块化规范

- CommonJS API 定义很多普通应用程序（主要指非浏览器的应用）使用的 API，从而填补了这个空白。它的终极目标是提供一个类似 Python，Ruby 和 Java 标准库。这样的话，开发者可以使用 CommonJS API 编写应用程序，然后这些应用可以运行在不同的 JavaScript 解释器和不同的主机环境中。NodeJS是CommonJS规范的实现。CommonJS 定义的模块分为: **{模块引用(require)} {模块定义(exports)} {模块标识(module)}**,所以浏览器是跑不了commonjs 的，因为没有这几个变量。。
- AMD 解决在浏览器也可以适用的模块化解决方案，而且还有一个问题是 commonjs 加载模块是同步的，在浏览器运行时需要等待加载资源，因此造成假死的情况，因此异步加载的浏览器端模块化解决方案就诞生了。AMD 是 "Asynchronous Module Definition" 的缩写，意思就是"异步模块定义"。它采用异步方式加载模块，模块的加载不影响它后面语句的运行。所有依赖这个模块的语句，都定义在一个回调函数中，等到加载完成之后，这个回调函数才会运行（require([module], callback)需要2个参数，依赖的模块数组，加载完成回调函数）。AMD 模块必须采用特定的 define(function(){}) 函数,如果此模块依赖其它模块define函数还要传入一个依赖的模块数组参数；
- CMD 和 AMD 类似也是异步模块化的解决方案，一样是并行加载所有依赖的模块, 但不会立即执行模块, 等到真正需要(require)的时候才开始解析，不容易造成顺序依赖的问题。

# 框架相关

## react 生命周期
> 实例化
- getDefaultProps
- getInitialState
- componentWillMount
- render
- componentDidMount
> 存在期
- componentWillReceiveProps
- shouldComponentUpdate
- componentWillUpdate
- render
- componentDidUpdate
> 销毁期
- componentWillUnmount

## vue 生命周期
> create -> mount -> update(绑定的数据或传入的属性改变) -> destory
- beforeCreate
  observe data
  init event
- created
- beforeMount
- mounted
- beforeUpdate
- updated
- beforeDestory
- destoryed

## 为什么使用 react

- 由于virtual DOM的存在，使得平台兼容性强，后续公司可基于该方案落地RN到客户端研发；
- React是一个生态圈健壮的以解决组件化开发为目标的前端框架，文档全面；
- React支持服务端同构渲染（虽说Vue也支持吧），方便后续做基于SSR的RTT优化。

## 什么时候使用 redux

遵循了 flux 架构的思想（store => view => dispatch(action) => store => ...）
> Redux 单一数据集合以及绑定策略节省了大量的前端代码，并且对数据进行集中维护。结合单向数据流的概念，强迫组件更加纯粹。

- 数据集合较庞大、数据关联性较强
- 业务流程较复杂
- 绝大多数子业务可被抽象为复用的视图或者组件

总结：如果这个状态不影响其他部分的业务逻辑并且足够简单，就使用 react state。

# js 相关

## 闭包

> 闭包就是当函数在其它地方使用的时候能保存下函数所需要的运行环境（一些局部变量），也即是函数能保存下函数诞生时的环境。可以理解为：**函数运行在它们被定义的作用域里，而不是它们被执行的作用域里。**

## 为什么需要闭包

> 局部变量无法共享和长久的保存，而全局变量可能造成变量污染，所以我们希望有一种机制既可以长久的保存变量又不会造成全局污染。

## 如何使用闭包？

1. 定义外层函数，封装被保护的局部变量；
2. 定义内层函数，执行对外部函数变量的操作；
3. 外层函数返回内层函数的对象，并且外层函数被调用，结果保存在一个全局的变量中。

## 高阶函数

> 一个函数就接收另一个函数作为参数，这种函数就称之为高阶函数。常见的高阶函数： map／reduce; filter; sort

## 数组操作方法有哪些
> push,pop,shift,unshift,reverse,splice, join,concat,indexOf,sort,slice,filter,map,forEach,some,every

## 数组去重
> 1.遍历数组法；2.对象键值法；3.数组下标法；4.排序相邻去除法

## session 和 cookie
> Session 是在服务端保存的一个数据结构，用来跟踪用户的状态，这个数据可以保存在集群、数据库、文件中；
Cookie 是客户端保存用户信息的一种机制，用来记录用户的一些信息，也是实现 Session 的一种方式。用来服务端识别特定的客户；默认浏览器关闭失效；

## LocalStorage 和 sessionStorage
> 都是 web Storage，HTML5 引入的一个重要的功能，在前端开发的过程中会经常用到，它可以在客户端本地存储数据，类似cookie，但其功能却比cookie强大的多。cookie的大小只有4Kb左右（浏览器不同，大小也不同），而web Storage的大小有5MB；
localStorage 的生命周期是永久性的。假若使用localStorage存储数据，即使关闭浏览器，也不会让数据消失，除非主动的去删除数据；
sessionStorage 的生命周期是在浏览器关闭前。也就是说，在整个浏览器未关闭前，其数据一直都是存在的。

## call, apply, bind
> 都是改变调用的函数中的 this；区别：fn.call(that, a, b,...) fn.apply(that, arguments)参数不相同，apply是以数组的形式传入，call是一个一个传入，两者都是立即执行函数，而 bind 是返回修改 this 完成后的函数，需要再去执行。

## ES6 主要的新特性

- Block-Scoped Constructs Let and Const（块作用域构造Let and Const）
- Destructuring Assignment （解构赋值）
- Multi-line Strings （多行字符串）
- Template Literals （模板文本）
- Arrow Functions （箭头函数）in ES6
- Default Parameters（默认参数）
- Promise
- Classes（类）
- Enhanced Object Literals （增强的对象文本 Object.create）
- Modules（模块）

# css 相关

## BFC
> 块级格式化上下文，它是指一个独立的块级渲染区域，只有Block-level BOX参与，该区域拥有一套渲染规则来约束块级盒子的布局，且与区域外部无关。
满足下列 CSS 声明之一的元素便会生成 BFC
- 根元素
- float的值不为none
- overflow的值不为visible
- display的值为inline-block、table-cell、table-caption
- position的值为absolute或fixed

## 垂直水平居中布局

- 使用绝对定位和负外边距对块级元素进行垂直居中
- 使用绝对定位和transform（transform: translate(-50%, -50%);）
- flex 弹性布局（justify-content: center;align-items: center;）

## 浮动引起的问题？什么时候要清除浮动？如何清除浮动

> 父元素坍塌；
- 在父元素的最后加一个冗余元素并为其设置clear:both
- 采用伪元素，这里我们使用:after。添加一个类 clearfix
- 给父元素添加overflow:hidden || auto

## 元素不可见，且不可点击

- display: none;
- height: 0; overflow: hidden;
- position: absolute; top: -999em;
- position: absolute; visibility: hidden;
- position: absolute; zoom: 0.001;

# 性能优化

1. 减少http请求次数：CSS Sprites, JS、CSS源码压缩、图片大小控制合适；网页Gzip，CDN托管，data缓存 ，图片服务器。
2. 前端模板 JS+数据，减少由于HTML标签导致的带宽浪费，前端用变量保存AJAX请求结果，每次操作本地变量，不用请求，减少请求次数
3. 用innerHTML代替DOM操作，减少DOM操作次数，优化javascript性能。
4. 当需要设置的样式很多时设置className而不是直接操作style。
5. 少用全局变量、缓存DOM节点查找的结果。减少IO读取操作。
6. 避免使用CSS Expression（css表达式)又称Dynamic properties(动态属性)。
7. 图片预加载，将样式表放在顶部，将脚本放在底部 加上时间戳。
8. 避免在页面的主体布局中使用table，table要等其中的内容完全下载之后才会显示出来，显示div+css布局慢.
对普通的网站有一个统一的思路，就是尽量向前端优化、减少数据库操作、减少磁盘IO。向前端优化指的是，在不影响功能和体验的情况下，能在浏览器执行的不要在服务端执行，能在缓存服务器上直接返回的不要到应用服务器，程序能直接取得的结果不要到外部取得，本机内能取得的数据不要到远程取，内存能取到的不要到磁盘取，缓存中有的不要去数据库查询。减少数据库操作指减少更新次数、缓存结果减少查询次数、将数据库执行的操作尽可能的让你的程序完成（例如join查询），减少磁盘IO指尽量不使用文件系统作为缓存、减少读写文件次数等。程序优化永远要优化慢的部分，换语言是无法“优化”的。

# git

## pull 与 fetch

> git pull相比git fetch相当于是从远程获取最新版本到本地，但不会自动merge。如果需要有选择的合并git fetch是更好的选择。效果相同时git pull将更为快捷

## rebase 与 merge

>  两者都是合并分支时使用；rebase 根据这个单词的意思可以看出，就是改变当前分支的基础，就是说改变这个分支最初分出来的那个点，移动到更新的节点上，达到其它分支合并到当前分支的作用； merge 很简单的两个分支合并，把两个分支合并解决冲突作为一次提交到新的分支上，相比rebase 多了一次合并提交的节点；
> 使用上，其它分支 merge 到主分支，其它分支 rebase 主分支！

# 安全

## xss

> XSS 攻击 是Web攻击中最常见的攻击方法之一，它是通过对网页注入可执行代码且成功地被浏览器执行，达到攻击的目的，形成了一次有效 XSS 攻击，一旦攻击成功，它可以获取用户的联系人列表，然后向联系人发送虚假诈骗信息，可以删除用户的日志等等，有时候还和其他攻击方式同时实施比如 SQL 注入攻击服务器和数据库、Click劫持、相对链接劫持等实施钓鱼，它带来的危害是巨大的，是web安全的头号大敌。

实施XSS攻击需要具备两个条件：
1. 需要向 web 页面注入恶意代码；
2. 这些恶意代码能够被浏览器成功的执行。

防范：对用户输入内容的一些特殊字符进行转义；严格控制用户输入非法内容；如：<>""''%;()&+等

## sql 注入

> SQL Injection 就是通过把恶意的 SQL 命令插入到 Web 表单让服务器执行，最终达到欺骗服务器或数据库执行恶意的 SQL 命令.

防范：对用户提交内容特殊字符进行转义，如：单引号，双横杠等

## CSRF

> CSRF跨站点请求伪造(Cross—Site Request Forgery)，跟XSS攻击一样，存在巨大的危害性，你可以这样来理解：
 攻击者盗用了你的身份，以你的名义发送恶意请求，对服务器来说这个请求是完全合法的，但是却完成了攻击者所期望的一个操作，比如以你的名义发送邮件、发消息，盗取你的账号，添加系统管理员，甚至于购买商品、虚拟货币转账等。

 CSRF攻击攻击原理及过程如下(其中Web A为存在CSRF漏洞的网站，Web B为攻击者构建的恶意网站，User C为Web A网站的合法用户)：

 1. 用户C打开浏览器，访问受信任网站A，输入用户名和密码请求登录网站A；
 2. 在用户信息通过验证后，网站A产生Cookie信息并返回给浏览器，此时用户登录网站A成功，可以正常发送请求到网站A；
 3. 用户未退出网站A之前，在同一浏览器中，打开一个TAB页访问网站B；
 4. 网站B接收到用户请求后，返回一些攻击性代码，并发出一个请求要求访问第三方站点A；
 5. 浏览器在接收到这些攻击性代码后，根据网站B的请求，在用户不知情的情况下携带Cookie信息，向网站A发出请求。网站A并不知道该请求其实是由B发起的，所以会根据用户C的Cookie信息以C的权限处理该请求，导致来自网站B的恶意代码被执行。
