#!/bin/zsh

# Default values
private_flag="false"

# Function to display usage
usage() {
    echo "Usage: $0 [--private|-p] <library_name>"
    exit 1
}

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --private | -p)  # --private または -p の場合
            private_flag="true"
            shift
            ;;
        *)  # 最後の引数がライブラリ名
            LIBRARY_NAME=$1
            shift
            ;;
    esac
done

# ライブラリ名をチェック
if [ -z "$LIBRARY_NAME" ]; then
    usage  # ライブラリ名が指定されていない場合は usage を表示
fi

# 現在のディレクトリがホームディレクトリかどうかを確認
if [[ "$PWD" != "$HOME" ]]; then
    echo "Warning: You are not in your home directory!"
    exit 2
else
    echo "You are in your home directory."
fi

# ライブラリ名の処理
echo "Library name: $LIBRARY_NAME"
echo "Private flag: $private_flag"

# Git リポジトリの初期化
cd ~/$LIBRARY_NAME
# git init
if [ ! -d ".git" ]; then
    git init  # .git ディレクトリがない場合に初期化
    git add .
    git commit -m "version 0.0, Initial commit"
    echo "Initialized a new Git repository."
else
    echo "Git repository already initialized."
fi

# リモートリポジトリをターミナル上から作成する
if [ "$private_flag" = "true" ]; then
    echo "Private flag is set."
    gh repo create $LIBRARY_NAME --private --source=. --remote=origin
else
    echo "Private flag is not set."
    gh repo create $LIBRARY_NAME --public --source=. --remote=origin
fi
# リモートリポジトリのURLを設定
REPO_URL="https://github.com/krypf/$LIBRARY_NAME.git"
# git remote add origin $REPO_URL

# リモートリポジトリの設定とプッシュ
git branch -M main
git push -u origin main

echo "Library '$LIBRARY_NAME' pushed to repository '$REPO_URL' successfully."
