COMMENT=$1

if [ -z "$COMMENT" ]; then
  echo "Usage: $0 <library_name>"
  exit 1
fi

git add .
git commit -m "changed $COMMENT"
git push