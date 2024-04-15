#!/bin/bash

# assetsディレクトリのパス
assetsDir="src/assets"

# index.ts ファイルの初期化
indexFile="$assetsDir/index.ts"
cat /dev/null > $indexFile

# src/assets 配下の画像ファイルを検索し、処理を行う
find $assetsDir -type f | while read -r file; do
    mimeType=$(file --mime-type -b "$file")
    case "$mimeType" in (image/*)
            # ファイルパスから 'src/assets/' を除去してPascalCaseに変換
            relativePath="${file#$assetsDir/}"
            pascalName=$(echo "$relativePath" | awk -F'[/_-]' '{
                pascal = "";
                for (i = 1; i <= NF; i++) {
                    # ファイル拡張子を除去
                    gsub(/\.[^.]*$/, "", $i);
                    # 各セグメントの最初の文字を大文字にし、残りをそのまま
                    $i = toupper(substr($i, 1, 1)) tolower(substr($i, 2));
                    # 非アルファヌメリック文字を削除
                    gsub(/[^a-zA-Z0-9]/, "", $i);
                    pascal = pascal $i;
                }
                print pascal;
            }')

            # index.ts にエクスポート文を追加
            echo "export { default as $pascalName } from './$relativePath';" >> $indexFile
            ;;
    esac
done

# indexFile の内容をアルファベット順にソートして上書き
sort $indexFile -o $indexFile