#!/bin/bash

# アイコン生成スクリプト
# 使用方法: ./generate_icons.sh original_image.png

if [ "$#" -ne 1 ]; then
    echo "使用方法: $0 <元画像ファイル>"
    exit 1
fi

ORIGINAL_IMAGE="$1"
ICON_DIR="QuickShortcutsApp/Assets.xcassets/AppIcon.appiconset"

if [ ! -f "$ORIGINAL_IMAGE" ]; then
    echo "エラー: ファイル '$ORIGINAL_IMAGE' が見つかりません"
    exit 1
fi

echo "アイコンを生成中..."

# 各サイズのアイコンを生成
sizes=(
    "16:icon_16x16.png"
    "32:icon_16x16@2x.png"
    "32:icon_32x32.png"
    "64:icon_32x32@2x.png"
    "128:icon_128x128.png"
    "256:icon_128x128@2x.png"
    "256:icon_256x256.png"
    "512:icon_256x256@2x.png"
    "512:icon_512x512.png"
    "1024:icon_512x512@2x.png"
)

for size_info in "${sizes[@]}"; do
    IFS=':' read -r size filename <<< "$size_info"
    echo "生成中: ${size}x${size} -> $filename"
    sips -z "$size" "$size" "$ORIGINAL_IMAGE" --out "$ICON_DIR/$filename" > /dev/null 2>&1
done

echo "アイコン生成完了！"
echo "ファイルは $ICON_DIR/ に保存されました"
