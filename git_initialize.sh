# ライブラリ名を引数から取得
LIBRARY_NAME=$1

if [ -z "$LIBRARY_NAME" ]; then
  echo "Usage: $0 <library_name>"
  exit 1
fi

# Gitリポジトリの初期化
cd ~/$LIBRARY_NAME
git init
git add .
git commit -m "Initial commit"

# リモートリポジトリをターミナル上から作成する
 gh repo create $LIBRARY_NAME --public --source=. --remote=origin

# リモートリポジトリのURLを設定
REPO_URL="https://github.com/krypf/$LIBRARY_NAME.git"

# リモートリポジトリの設定とプッシュ
git remote add origin $REPO_URL
git branch -M main
git push -u origin main

echo "Library '$LIBRARY_NAME' pushed to repository '$REPO_URL' successfully."
