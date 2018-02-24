---
title: questions
category: 学习笔记
date: 2018-02-23 16:55:31
tags: 前端问题
---

# node 相关

## require的原理及执行过程
> 首先从缓存中读取，没有的话需要加载文件；根据参数来确定文件路径（传入的是绝对路径还是相对路径，路径格式，是／还是文件名结尾，是否需要加 index.js 等）；然后就是加载文件，不同格式要用不同的解析，如：js 要进行编译，json要用 JSON.parse 解析等；加载 js 文件是在 js 文件用函数包装，传入 exports，require 等参数；

## OSI 七层模型
> OSI（Open System Interconnection）开放系统互连参考模型，是ISO制定的一个用于计算机或通信系统间互联的标准体系，它是一个七层抽象模型，从低到高分别是：物理层、数据链路层、网络层、传输层、会话层、表示层和应用层。目的是为不同计算机互连提供一个共同的基础和标准框架，OSI中包括一系列抽象的术语、概念，也包括具体的协议，遵循OSI参考模型和相关协议能够实现计算机或通信系统间互联互通。

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

# js 相关

## 数组操作方法有哪些
> push,pop,shift,unshift,reverse,splice, join,concat,indexOf,sort,slice,filter,map,forEach,some,every

## 数组去重
> 1.遍历数组法；2.对象键值法；3.数组下标法；4.排序相邻去除法

## session 和 cookie
> Session 是在服务端保存的一个数据结构，用来跟踪用户的状态，这个数据可以保存在集群、数据库、文件中；
Cookie 是客户端保存用户信息的一种机制，用来记录用户的一些信息，也是实现 Session 的一种方式。用来服务端识别特定的客户；默认浏览器关闭失效；

## LocalStorage 和sessionStorage
> 都是 web Storage，HTML5 引入的一个重要的功能，在前端开发的过程中会经常用到，它可以在客户端本地存储数据，类似cookie，但其功能却比cookie强大的多。cookie的大小只有4Kb左右（浏览器不同，大小也不同），而web Storage的大小有5MB；
localStorage 的生命周期是永久性的。假若使用localStorage存储数据，即使关闭浏览器，也不会让数据消失，除非主动的去删除数据；
sessionStorage 的生命周期是在浏览器关闭前。也就是说，在整个浏览器未关闭前，其数据一直都是存在的。

# css 相关

## BFC
> 块级格式化上下文，它是指一个独立的块级渲染区域，只有Block-level BOX参与，该区域拥有一套渲染规则来约束块级盒子的布局，且与区域外部无关。
满足下列CSS声明之一的元素便会生成 BFC
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
- 给父元素添加overflow:hidden ||auto

## 元素不可见，且不可点击

- display: none;
- height: 0; overflow: hidden;
- position: absolute; top: -999em;
- position: absolute; visibility: hidden;
- position: absolute; zoom: 0.001;
