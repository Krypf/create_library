#!/bin/bash

# ライブラリ名を引数から取得
LIBRARY_NAME=$1

if [ -z "$LIBRARY_NAME" ]; then
  echo "Usage: $0 <library_name>"
  exit 1
fi

# ディレクトリ構造の作成
mkdir -p $LIBRARY_NAME/$LIBRARY_NAME
mkdir -p $LIBRARY_NAME/tests

# __init__.pyファイルの作成
touch $LIBRARY_NAME/$LIBRARY_NAME/__init__.py
# requirements ファイルの作成
touch $LIBRARY_NAME/requirements.txt
# 最上層ファイルの作成
touch $LIBRARY_NAME/main.py
touch $LIBRARY_NAME/run.sh

# example_module.pyの作成
cat <<EOL > $LIBRARY_NAME/$LIBRARY_NAME/example_module.py
def hello_world():
    return "Hello, World!"
EOL

# test_example.pyの作成
cat <<EOL > $LIBRARY_NAME/tests/test_example.py
import unittest
from $LIBRARY_NAME.example_module import hello_world

class TestExampleModule(unittest.TestCase):
    def test_hello_world(self):
        self.assertEqual(hello_world(), "Hello, World!")

if __name__ == "__main__":
    unittest.main()
EOL

# setup.pyの作成
cat <<EOL > $LIBRARY_NAME/setup.py
from setuptools import setup, find_packages
with open('requirements.txt') as f:
    requirements = f.read().splitlines()

setup(
    name="$LIBRARY_NAME",
    version="0.1",
    packages=find_packages(),
    install_requires=requirements,
    test_suite='tests',
)
EOL

# README.mdの作成
cat <<EOL > $LIBRARY_NAME/README.md
# $LIBRARY_NAME

This is a Python library "$LIBRARY_NAME".
EOL

# .gitignoreの作成
cat <<EOL > $LIBRARY_NAME/.gitignore
__pycache__/
*.pyc
.DS_Store
[0-9][0-9].py
*.env
*.env.*
data/
EOL

# LICENSE.txtの作成
cat <<EOL > $LIBRARY_NAME/LICENSE.txt
MIT License

Copyright (c) $(date +%Y) Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOL

echo "Library structure for '$LIBRARY_NAME' created successfully."
