---
title: redux 的一些知识点
category: 学习笔记
date: 2018-03-15 14:37:51
tags: redux
---

## redux 应用中数据的生命周期

1. 调用 store.dislpatch(action)
2. store 调用传入的 reducer 函数
3. 多个子 reducer 输出合并成一个单一的 state 树
4. store 保存根 reducer 返回的完整的 state 树

## redux 的一些中间价

### redux-thunk （异步 action 创建函数）

使用了这个 middleware，action 创建函数除了返回 action 对象外还可以返回函数。当返回函数就会被 redux-thunk middleware 执行。这个函数可以 dispatch action，在任何时候，因此是异步 action 创建函数。

### redux-promise (promise 来代替创建函数)

这个 middleware 是用 promise 对象来代替 action 创建函数，即可以直接 dispatch promise 对象。

### redux-saga

在组件中触发 action，从而触发另外一些 action 去获取数据，用的是 generator 函数。

## 自己实践

通过 redux-actions 的 createAction[s] 创建 action 创建函数，搭配 redux-thunk 和 redux-promise 返回请求的 promise ，去获取请求；而且在关联到组件中时利用 redux 的 bindActionCreator[s] 不暴漏 dispatch 函数给组件，调用函数的方式去触发 action，整个过程容易理解，符合 flux 的单向数据流的架构思想。
