---
title: DDS Key
description: 'DDS 中 Key 的定义与作用。'
publishDate: 2026-02-03 13:52:59
lang: zh
tags:
  - OMG DDS规范
  - dds
---
## key

### 定义

规范中对于 key 的描述为:

```
“A Key is a set of data fields that uniquely identifies a data instance within a Topic.”
```

- **Key 是数据类型（Topic Type）的一部分**
- **Key 由一个或多个成员字段组成**
- **Key 的取值组合在 Topic 范围内唯一标识一个 Data Instance**
- **DDS 使用 Key 来区分不同的 Instances，而不是区分 Topics**

### 作用

Key 用来区分 **同一个 Topic 下的不同 Instance**。

从设计的角度来说，Key 给予 DDS 对象级状态管理的能力。

从现实的角度来说，可能存在多个同类型的传感器，他们可能都传输同一种结构的数据，比如说多个温度传感器。此时它们同时往控制器发送数据，可以通过设置 `id@key` 来进行管理。DDS 内部会将数据流根据 id 进行分隔。

更进一步的说，RHC 会根据 instance（key）的粒度来进行数据管理，将同一个 key 值的数据放到一个 instance 节点下。关于生命周期，keep-last 是 instance 粒度的，也就是 keep-last 是对每个 instance 节点下需要保留多少个 sample 进行了定义。

当然，你可以设置 unkey，但是你需要自己在应用层负责区分以及处理所有的数据流，以及自己决定它们的生命周期（设置合理的 keep-last，此时存在某个 key 数据多，某个 key 数据少的问题）。
