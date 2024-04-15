# imageの扱い方

1. 新たな画像を `src/assets` 配下に配置する

2. 下記スクリプトを実行

```
pnpm run gen-assets
```

=> `src/assets/index.ts` にexport行が生成される

3. `import { Xxxx } from '@/assets'` の形でimportして使用する
