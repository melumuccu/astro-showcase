#!/bin/zsh

# 画像ディレクトリの定義
imagesDir="src/images"
indexFile="$imagesDir/index.ts"

# index.tsを空のファイルとして初期化
cat /dev/null > $indexFile

# 画像ファイルの処理
find $imagesDir -type f | while read file; do
  # ファイルのMIMEタイプを取得
  mimeType=$(file -b --mime-type "$file")

  # MIMEタイプが画像であるか確認
  if [[ $mimeType == image/* ]]; then
    # ファイルの絶対パスを取得 (realpathの代わりに)
    filePath=$(echo ${file#$PWD/})
    # ファイル名のみを取得（拡張子除く）
    fileName=$(basename $file | sed 's/\.[^.]*$//')
    # ファイル名をPascalCaseに変換 (awkを使用)
    pascalName=$(echo $fileName | awk -F"[-_]" '{result=""; for(i=1;i<=NF;i++) result=result toupper(substr($i,1,1)) tolower(substr($i,2)); print result}')
    # index.tsにエクスポート文を追記
    echo "export { default as $pascalName } from './$filePath';" >> $indexFile
  fi
done

# indexFileの内容をアルファベット順にソートして上書き
sort $indexFile -o $indexFile