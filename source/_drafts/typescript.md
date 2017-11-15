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

#### 布尔值

```js
  let isDone: boolean = false
```

#### 数字

```js
  let count: number = 6
  let count: number = 0xf00d
  let count: number = 0b1010
  let count: number = 0o744
```

#### 字符串

```js
  let name: string = 'jack'
```

#### 数组

```js
  let list: number[] = [1, 2, 3]
  let list Array<number> = [1, 2, 3]
```

#### 元组 Tuple

```js
  let x: [string, number]
  x = ['hello', 10] // ok
  x = [10, 'hello'] // error
  x[3] = 'world' // ok, 越界的元素可以赋值 string 或 number 类型，感觉和 js 数组类似，只是限定了类型
  x[7] = true // error
```

#### 枚举

```js
  enum Color { Red, Green, Blue } // 默认情况下，从0开始为元素编号,即：Color { 0, 1, 2 }
  let c: Color = Color.Green
  // 也可以手动的指定成员的数值。 例如，我们将上面的例子改成从1开始编号
  enum Color { Red = 1, Green, Blue }
  // 也可以全部手动赋值
  enum Color { Red = 1, Green = 2, Blue = 7 }
```

#### 任意值

```js
  let ant: any = 4
  ant = 'jack'
  ant.ifItExists() // okay, ifItExists might exist at runtime
  ant.toFixed() // okay, toFixed exists (but the compiler doesn't check)
  let list: any[] = [1, true, 'jack']
```

#### 空值

```js
  let unusable: void = undefined
  function log(): void {
    console.log('this is a function')
  }
```

#### undefined 和 null 也是和自己相同的类型，和 void 一样作用不大

```js
  let u: undefined = undefined
  let n: null = null
```

#### never 类型，表示永不存在的类型

  never类型是任何类型的子类型，也可以赋值给任何类型；然而，没有类型是never的子类型或可以赋值给never类型（除了never本身之外）。 即使any也不可以赋值给never。

```js
  // 返回never的函数必须存在无法达到的终点
  function error(message: string): never {
      throw new Error(message);
  }
  // 推断的返回值类型为never
  function fail() {
      return error("Something failed");
  }
  // 返回never的函数必须存在无法达到的终点
  function infiniteLoop(): never {
      while (true) {
      }
  }
```

#### 类型断言

```js
  let someValue: any = 'this is a string'
  // 两种形式，等价的。然而在 jsx 使用 ts 时，只有 as 是被允许的
  let strLength: number = (<string>someValue).length
  let strLength: number = (someValue as string).length
```

### 2.变量声明



### 3.
...
