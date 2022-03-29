#!/usr/bin/env bash

shopt -s extglob
rm -rf !(mkdocs.yml|README.md|docs|site|.git|clear_code.sh|requirements.txt|build_option.ini|mac_clear_code.sh|.gitignore|venv|mac_sed.sh)
pip freeze > requirements.txt
mkdocs build
mv site/* ./
git add . -A 
git commit -m "commit_message"
git push