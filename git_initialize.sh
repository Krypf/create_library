#!/bin/zsh

# ライブラリ名を引数から取得
LIBRARY_NAME=$1

if [ -z "$LIBRARY_NAME" ]; then
  echo "Usage: $0 <library_name>"
  exit 1
fi

# Default values
private_flag="false"

# Function to display usage
usage() {
    echo "Usage: $0 [--private]"
    exit 1
}

# Gitリポジトリの初期化
cd ~/$LIBRARY_NAME
git init
git add .
git commit -m "Initial commit"


# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --private)
            private_flag="true"
            shift
            ;;
        *)
            usage
            ;;
    esac
done

# Your script logic here
if [ "$private_flag" = "true" ]; then
    echo "Private flag is set."
    gh repo create $LIBRARY_NAME --private --source=. --remote=origin
else
    echo "Private flag is not set."
    gh repo create $LIBRARY_NAME --public --source=. --remote=origin
fi

# リモートリポジトリをターミナル上から作成する

# リモートリポジトリのURLを設定
REPO_URL="https://github.com/krypf/$LIBRARY_NAME.git"

# リモートリポジトリの設定とプッシュ
# git remote add origin $REPO_URL
git branch -M main
git push -u origin main

echo "Library '$LIBRARY_NAME' pushed to repository '$REPO_URL' successfully."
