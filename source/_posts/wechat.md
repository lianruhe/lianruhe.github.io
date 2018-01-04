---
title: wechat
category: 学习笔记
date: 2017-12-18 15:37:27
tags: WeChat
---
# 微信小程序 开发学习记录

## 准备

根据微信公众平台 [简易教程](https://mp.weixin.qq.com/debug/wxadoc/dev/index.html) 一步一步来，申请账号，安装 IDE，编译之后就可以看到你的第一个微信小程序了。
好吧，又是 Hello Word！
那么恭喜你！你已经成功创建了你的第一个小程序，点击预览按钮，通过微信的扫一扫在手机上体验你的第一个小程序。

## 小程序的文件结构

小程序包含一个描述整体程序的 app 和多个描述各自页面的 page。根目录下面有三个文件 app.js(入口文件)，app.json(公共配置文件)，app.wxss(全局样式)。

一个小程序页面由四个文件组成：
1.json 配置文件
2.wxml 模版文件
3.wxss 样式文件
4.js 代码文件
**注意：为了方便开发者减少配置项，描述页面的四个文件必须具有相同的路径与文件名。**

### JSON 配置文件

app.json 是当前小程序的全局配置，包括了小程序的所有页面路径、界面表现、网络超时时间、底部 tab 等。
其它的配置项可以参考配置 [app.json](https://mp.weixin.qq.com/debug/wxadoc/dev/framework/config.html)。

### WXML 模版

就是 HTML, 不同的是标签是 wechat 自定义的。例如：view, button, text 等等。多了 wx:if 等这样的属性，如果你用过 vue 的类似属性，那么很好理解，这里不便多说。具体文档可以看这里 [WXML](https://mp.weixin.qq.com/debug/wxadoc/dev/framework/view/wxml/)。

### WXSS 样式

好吧，这是 CSS！不过多了一些扩充和修改。
1.新增尺寸单位 rpx，不同的宽度和设备像素比，会自动换算，免去开发者的烦恼。
2.作用域的不同。app.wxss 作用于全局，其它在页面下面的 page.wxss 仅对当前页面生效。
3.wxss 仅支持部分 css 选择器。使用的时候要当心噢！
具体配置可以参考配置 [WXSS](https://mp.weixin.qq.com/debug/wxadoc/dev/framework/view/wxss.html)。

### JS 逻辑代码

HTML 是页面的表现，那么操作就是 js 来完成，例如点击一个按钮应该有什么动作：
```HTML
<view>{{ msg }}</view>
<button bindtap="clickMe">点击我</button>
```

button 上声明一个属性 bindtap 顾名思义是绑定了一个 tap 动作的事件，所以在 js 文件中就要声明 clickMe 这个方法来响应。
```js
Page({
  clickMe: function() {
    this.setData({ msg: "Hello World" })
  }
})
```
响应用户的操作就是这么简单，更详细的事件可以参考文档 [WXML - 事件](https://mp.weixin.qq.com/debug/wxadoc/dev/framework/view/wxml/event.html) 。

## 程序执行的流程

微信客户端在打开小程序之前会线加载相关的代码文件，可以理解为下载 html 和 js 等相关资源文件，不过这里解析不一样啦！
1.解析 app.json 全局配置，相关页面路径等
2.资源加载完成开始渲染页面和执行逻辑文件，首先就是 app.js 文件
3.每个程序都会有个 index page 文件夹，这也就是你的小程序的 home 页面，所以之后就是执行这里面的内容
