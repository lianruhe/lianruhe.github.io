---
title: TypeScript
category: 学习笔记
date: 2017-11-03 10:08:58
tags: TypeScript
---

## 前言

  目前 JavaScript 用来开发越来越大的系统，因为它的语法规则灵活多变，往往对后期的维护人员来说十分痛苦。而 TypeScript 的语法规则更倾向于后端语言，更具有逻辑可循，所以更加规范，更容易维护。
  当然 TypeScript 最终还是要编译成 JavaScript 的，毕竟使跑在浏览器上的，浏览器可没有 ts 的环境。TypeScript可以编译出纯净、 简洁的JavaScript代码，并且可以运行在任何浏览器上、Node.js环境中和任何支持ECMAScript 3（或更高版本）的JavaScript引擎中。

  以上是本人还没有学习 ts 之前的片面理解，学完之后再来补充。

  Let's go！

## React && webpack

### 1.依赖

```bash
$ npm install --save react react-dom @types/react @types/react-dom
$ npm install --save-dev typescript awesome-typescript-loader source-map-loader
```

使用 @types/ 前缀表示我们额外要获取 React 和 React-DOM 的声明文件。 通常当你导入像"react"这样的路径，它会查看 react 包； 然而，并不是所有的包都包含了声明文件，所以 TypeScript 还会查看 @types/react 包。

awesome-typescript-loader 可以让 Webpack 使用 TypeScript 的标准配置文件 tsconfig.json 编译 TypeScript 代码。 source-map-loader 使用 TypeScript 输出的 sourcemap 文件来告诉 webpack 何时生成自己的 sourcemaps。 这就允许你在调试最终生成的文件时就好像在调试 TypeScript 源码一样。

### 2.配置文件

```json
/* tsconfig.json */
{
  "compilerOptions": {
      "outDir": "./dist/",
      "sourceMap": true,
      "noImplicitAny": true,
      "module": "commonjs",
      "target": "es5",
      "jsx": "react"
  },
  "include": [
      "./src/**/*"
  ]
}
```
### 3.webpack 配置

```js
  module.exports = {
      entry: "./src/index.tsx",
      output: {
          filename: "bundle.js",
          path: __dirname + "/dist"
      },
      // Enable sourcemaps for debugging webpack's output.
      devtool: "source-map",
      resolve: {
          // Add '.ts' and '.tsx' as resolvable extensions.
          extensions: [".ts", ".tsx", ".js", ".json"]
      },
      module: {
          rules: [
              // All files with a '.ts' or '.tsx' extension will be handled by 'awesome-typescript-loader'.
              { test: /\.tsx?$/, loader: "awesome-typescript-loader" },

              // All output '.js' files will have any sourcemaps re-processed by 'source-map-loader'.
              { enforce: "pre", test: /\.js$/, loader: "source-map-loader" }
          ]
      },

      // When importing a module whose path matches one of the following, just
      // assume a corresponding global variable exists and use that instead.
      // This is important because it allows us to avoid bundling all of our
      // dependencies, which allows browsers to cache those libraries between builds.
      externals: {
          "react": "React",
          "react-dom": "ReactDOM"
      }
  }
```
大家可能对 externals 字段有所疑惑。 我们想要避免把所有的 React 都放到一个文件里，因为会增加编译时间并且浏览器还能够缓存没有发生改变的库文件。

理想情况下，我们只需要在浏览器里引入 React 模块，但是大部分浏览器还没有支持模块。 因此大部分代码库会把自己包裹在一个单独的全局变量内，比如：jQuery 或 _ 。 这叫做“命名空间”模式，webpack 也允许我们继续使用通过这种方式写的代码库。 通过我们的设置 "react": "React"，webpack 会神奇地将所有对 "react" 的导入转换成从 React 全局变量中加载。

## 学习笔记

### 1.基础类型


### 2.变量声明
### 3.
...
