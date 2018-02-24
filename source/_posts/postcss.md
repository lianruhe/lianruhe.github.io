---
title: Postcss 常用的语法总结 (wip...)
category: 学习笔记
date: 2017-11-06 11:42:07
tags: postcss
---

[参考文献](https://www.w3cplus.com/preprocessor/sass-to-postcss.html)

## 1.自定义属性

postcss 自定义属性仅适用于属性值，他们不能被用于选择器，属性名称或媒体查询。

```css
:root {
  --white: #fff;
  --grey: #1e1e1d;
  --yellow: #ffad15;
  --offwhite: #f8f8f8;
  ...
}

/************/
a {
  color: var(--yellow);
}
```

## 2.颜色函数

color, shade, alpha

```css
color: color(#f6f6f6 shade(20%));
color: color(#f6f6f6 shade(20%) alpha(40%));
```

## 3.类占位符

@apply 允许你在选择器中引用一组已存储样式。我将使用 @apply 规则来替代 Sass 中的 ( %placeholder @extend )。

```css
:root {
  ...
  --franklin: {
    font-family: 'futura-pt',
    helvetica, sans-serif;
  };
  --franklin-heading: {
    @apply --franklin;
    font-weight: 700;
    line-height: 1.1;
    text-transform: uppercase;
  };
}

/************/
.my-heading {
  @apply --franklin-heading;
}
```

## 4.混合宏

在 Sass 中经常使用到混合宏(@mixin @include)，可以简写样式代码。但是在 postcss 中没有类似的功能，因为我觉得可以用 css 自身的类名去实现，没有必要做深层的嵌套，一层嵌套用类占位符就可以了。
