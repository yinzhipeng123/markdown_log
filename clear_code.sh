#!/usr/bin/env bash

shopt -s extglob
rm -rf !(mkdocs.yml|README.md|docs|site|.git|clear_code.sh|requirements.txt)
pip freeze > requirements.txt
mkdocs build
mv site/* ./
git add . -A 
git commit -m "commit_message"
git push