# Layden's Blog

English | [简体中文](./README-zh-CN.md)

My personal blog site, built with [Astro](https://astro.build/) and based on the [Astro Theme Pure](https://github.com/cworld1/astro-theme-pure) template.

## Local development

Requirements:

- Node.js 18+
- Bun (recommended)

```bash
# Install dependencies
bun install

# Start dev server
bun dev
```

## Writing posts

Blog posts live in `src/content/blog/` (`.md` / `.mdx`). Tags are defined via frontmatter:

```yaml
tags:
  - c
  - cpp
  - valorant
```

Create a new post (folder mode recommended):

```bash
bun run pure new -f -l zh "My New Post"
```

## Deploy

Vercel preset: **Astro**

- Install: `bun install`
- Build: `bun run build`
- Output: `dist`

## Credits

This site is based on [cworld1/astro-theme-pure](https://github.com/cworld1/astro-theme-pure) (Apache-2.0).

## License

Apache-2.0. See `LICENSE`.
