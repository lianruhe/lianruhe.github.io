---
title: webpack
category: 学习笔记
date: 2018-03-12 17:10:01
tags: webpack
---

## webpack 模块化（CommonJS 模块）

文章参考：[webpack 打包原理](https://www.jianshu.com/p/e24ed38d89fd)

webpack 只是一个打包模块的机制，只是把依赖的模块转化成可以代表这些包的静态文件。并不是什么 commonjs 或者 amd 之类的模块化规范。webpack 就是识别你的入口文件，识别你的模块依赖，来打包你的代码。至于你的代码使用的是 commonjs 还是 amd 或者 es6 的 import，webpack都会对其进行分析，来获取代码的依赖。所以 webpack 做的就是分析代码，转换代码，编译代码，输出代码。webpack本身是一个node的模块，所以webpack.config.js是以 commonjs 形式书写的(node 中的模块化是 commonjs 规范的)。

我们用个简单的模块化的例子来看一下，webpack 打包后的代码：

```js
// index.js
var moduleTest = require('./test.js');
/******/
console.log('index.js');
/******/
module.fn1();
module.fn2();
```

```js
// test.js
exports.fn1 = function () {
  console.log('fn1')
};
/******/
exports.fn2 = function () {
  console.log('fn2')
};
```

打包后的代码
```js
// bundle.js
/******/ (function(modules) { // webpackBootstrap
/******/    // The module cache
/******/    var installedModules = {};
/******/
/******/    // The require function
/******/    function __webpack_require__(moduleId) {
/******/
/******/        // Check if module is in cache
/******/        if(installedModules[moduleId])
/******/            return installedModules[moduleId].exports;
/******/
/******/        // Create a new module (and put it into the cache)
/******/        var module = installedModules[moduleId] = {
/******/            exports: {},
/******/            id: moduleId,
/******/            loaded: false
/******/        };
/******/
/******/        // Execute the module function
/******/        modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/        // Flag the module as loaded
/******/        module.loaded = true;
/******/
/******/        // Return the exports of the module
/******/        return module.exports;
/******/    }
/******/
/******/    // expose the modules object (__webpack_modules__)
/******/    __webpack_require__.m = modules;
/******/
/******/    // expose the module cache
/******/    __webpack_require__.c = installedModules;
/******/
/******/    // __webpack_public_path__
/******/    __webpack_require__.p = "";
/******/
/******/    // Load entry module and return exports
/******/    return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {
/******/
        var moduleTest = __webpack_require__(1);
/******/
        console.log('index.js');
/******/
        moduleTest.fn1();
        moduleTest.fn2()
/******/
/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {
/******/
        exports.fn1 = function () {
          console.log('fn1')
        };
/******/
        exports.fn2 = function () {
          console.log('fn2')
        };
/******/
/***/ }
/**/ ]);
```

可以看到，整个打包生成的代码是一个IIFE（立即执行函数）,做了如下一些事情：
1. IIFE首先定义了installedModules ，这个变量被用来缓存已加载的模块。
2. 定义了__webpack_require__ 这个函数，函数参数为模块的id。这个函数用来实现模块的require。
3. __webpack_require__ 函数首先会检查是否缓存了已加载的模块，如果有则直接返回缓存模块的exports。
4. 如果没有缓存，也就是第一次加载，则首先初始化模块，并将模块进行缓存。
5. 然后调用模块函数，也就是前面webpack对我们的模块的包装函数，将module、module.exports和__webpack_require__作为参数传入。注意这里做了一个动态绑定，将模块函数的调用对象绑定为module.exports，这是为了保证在模块中的this指向当前模块。
6. 调用完成后，模块标记为已加载。
7. 返回模块exports的内容。
8. 利用前面定义的__webpack_require__ 函数，require第0个模块，也就是入口模块

webpack传入的第一个参数module是当前缓存的模块，包含当前模块的信息和exports；第二个参数exports是module.exports的引用，这也符合commonjs的规范；第三个__webpack_require__ 则是require的实现。

**原理还是很简单的，其实就是实现exports和require，然后自动加载入口模块，控制缓存模块，that's all。**

## webpack 模块化（ES模块）

还是用一个简单的例子：

```js
// index.js
import bar, {foo} from './module.js';
bar();
foo();
```

```js
// module.js
export default function bar () {
    return 1;
};
export function foo () {
    return 2;
}
```

模块打包后的代码

```js
// ...
([
  (function(module, exports, __webpack_require__) {
      /******/
      Object.defineProperty(exports, "__esModule", { value: true });
      /* harmony import */
      var __WEBPACK_IMPORTED_MODULE_0__m__ = __webpack_require__(1);
      /******/
      Object(__WEBPACK_IMPORTED_MODULE_0__m__["a" /* default */])();
      Object(__WEBPACK_IMPORTED_MODULE_0__m__["b" /* foo */])();
      /******/
  }),
  (function(module, exports, __webpack_require__) {
      /******/
      /* harmony export (immutable) */
      exports["a"] = bar;
      /* harmony export (immutable) */
      exports["b"] = foo;
      /******/
      function bar () {
          return 1;
      };
      function foo () {
          return 2;
      }
      /******/
  })
]);
```

index模块首先通过Object.defineProperty在__webpack_exports__上添加属性__esModule ，值为true，表明这是一个es模块。在目前的代码下，这个标记是没有作用的，至于在什么情况下需要判断模块是否es模块，后面会分析。

然后就是通过__webpack_require__(1)导入m.js模块，再然后通过module.xxx获取m.js中export的对应属性。注意这里有一个重要的点，就是所有引入的模块属性都会用Object()包装成对象，这是为了保证像Boolean、String、Number这些基本数据类型转换成相应的类型对象。

**webpack对于es模块的实现，也是基于自己实现的__webpack_require__ 和 __webpack_exports__ ，装换成类似于 commonjs 的形式。对于 es 模块和 commonjs 混用的情况，则需要通过 __webpack_require__.n 的形式做一层包装来实现。**
