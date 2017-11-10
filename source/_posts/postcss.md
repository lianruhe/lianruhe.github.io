---
title: Postcss 常用的语法总结 (wip...)
category: 学习笔记
date: 2017-11-06 11:42:07
tags: postcss
---

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

@apply 允许你在选择器中引用一组已存储样式。我将使用 @apply 规则来替代 Sass 中的 @extend。

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
