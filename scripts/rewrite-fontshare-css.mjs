import fs from 'node:fs/promises'
import path from 'node:path'

const [inputPath, outputPath, publicPrefix, fontFamily = 'Satoshi'] = process.argv.slice(2)

if (!inputPath || !outputPath || !publicPrefix) {
  console.error(
    'Usage: node scripts/rewrite-fontshare-css.mjs <input.css> <output.css> <publicPrefix> [fontFamily]'
  )
  process.exit(1)
}

const css = await fs.readFile(inputPath, 'utf8')
const urlRegex = /https:\/\/cdn\.fontshare\.com[^)"']+\.woff2/g
const urls = Array.from(new Set(css.match(urlRegex) ?? []))

let rewritten = css
for (const url of urls) {
  const fileName = path.basename(url)
  const localUrl = `${publicPrefix.replace(/\/$/, '')}/${fileName}`
  rewritten = rewritten.split(url).join(localUrl)
}

const header = `:root{--font-satoshi:"${fontFamily.replace(/"/g, '\\"')}";}\n`
await fs.writeFile(outputPath, `${header}${rewritten}`, 'utf8')
