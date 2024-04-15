# imageの扱い方

1. 新たな画像を `src/images` 配下に配置する

2. 下記スクリプトを実行

```
pnpm run gen-image
```

=> `src/images/index.ts` にexport行が生成される

3. `import { Xxxx } from '@/images'` の形でimportして使用する
