# Layden 的博客

[English](./README.md) | 简体中文

我的个人博客站点，基于 [Astro](https://astro.build/) 构建，并使用了 [Astro Theme Pure](https://github.com/cworld1/astro-theme-pure) 模板进行二次开发。

## 本地开发

环境要求：

- Node.js 18+
- Bun（推荐）

```bash
# 安装依赖
bun install

# 启动开发服务器
bun dev
```

## 写博客

博客文章位于 `src/content/blog/`（支持 `.md` / `.mdx`）。标签通过 frontmatter 的 `tags` 配置：

```yaml
tags:
  - c
  - cpp
  - valorant
```

新建一篇文章（推荐用文件夹模式）：

```bash
bun run pure new -f -l zh "我的新文章"
```

## 部署

Vercel 选择 **Astro**：

- Install：`bun install`
- Build：`bun run build`
- Output：`dist`

## 致谢

本项目基于 [cworld1/astro-theme-pure](https://github.com/cworld1/astro-theme-pure)（Apache-2.0）二次开发。

## 许可证

Apache-2.0，详见 `LICENSE`。
