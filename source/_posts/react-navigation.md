---
title: react-navigation
category: 学习笔记
date: 2018-04-13 15:10:06
tags: react-native
---

react-navigation 类比于 spa 中的路由，控制页面间的跳转，所以学习 RN 首先要学习它，下面我主要记录一些常用的用法和相关的 API，及自己本身学习过程中实践的例子，let's go！

## Navigation prop reference

### navigate

> 跳转到另一个页面模块的方法

```js
navigation.navigate({routeName, params, action, key})
// OR
navigation.navigate(routeName, params, action)
```

### goBack

> 关闭当前活动的页面，返回上一个页面

```js
goBack()
goBack(null)
```

### addListener

> 绑定生命周期事件

- willBlur 页面将要失去焦点事件
- willFocus 页面将要获得焦点
- didFocus 页面获得焦点后
- didBlur 页面失去焦点后

```js
const didBlurSubscription = this.props.navigation.addListener(
  'didBlur',
  payload => {
    console.debug('didBlur', payload);
  }
);

// Remove the listener when you are done
didBlurSubscription.remove();
```

### isFocused

> 返回当前页面是否是活跃状态

### state

> 当前页面的状态数据

```js
{
  // the name of the route config in the router
  routeName: 'profile',
  //a unique identifier used to sort routes
  key: 'main0',
  //an optional object of string options for this screen
  params: { hello: 'world' }
}
```

### setParams getParam

> 设置/获取当前的 param

## TabNavigator
