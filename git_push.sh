#!/bin/sh

ADD_TARGET=$1
COMMENT=$2

if [ -z "$ADD_TARGET" ] || [ -z "$COMMENT" ]; then
  echo "Usage: $0 <add_target> <commit_message>"
  exit 1
fi

git add "$ADD_TARGET"
git commit -m "$COMMENT"
git push
