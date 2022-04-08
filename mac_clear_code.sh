#!/bin/bash
# 获取脚本的当前所在位置
clear_code_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${clear_code_path}" || exit


function readINI() {
 INIFILE=$1; SECTION=$2; ITEM=$3
 option=$(awk -F '=' '/\['$SECTION'\]/{a=1}a==1&&$1~/'$ITEM'/{print $2;exit}' $INIFILE)
echo ${option}
}


echo "当前程序执行所在目录为：$(pwd)"

read -p "请确认当前所在目录，是否清理　$(pwd) 下文件，输入y，继续执行，输入n，停止执行：" confirm

if [[ ${confirm} == 'y' ]] ;then
  echo "继续执行"
elif [[ ${confirm} == 'n' ]];then
  exit 127
else
  echo "输入错误，脚本停止"
  exit 128
fi

shopt -s extglob
rm -rf !(mkdocs.yml|README.md|docs|site|.git|clear_code.sh|requirements.txt|build_option.ini|mac_clear_code.sh|.gitignore|venv|mac_sed.sh|see.sh|.gitignore)
echo "删除完成"
pip freeze > requirements.txt
mkdocs build
mv site/* ./
echo "web页面生成完成"

username=("$(readINI ${clear_code_path}/build_option.ini github username)")
email=("$(readINI ${clear_code_path}/build_option.ini github email)")
echo "设置当前提交用户名：" "${username[@]}"
echo "设置当前提交邮箱："  "${email[@]}"

read -p "请确认设置的用户名和邮箱，输入y，继续执行，输入n，停止执行：" git_confirm

if [[ ${git_confirm} == 'y' ]] ;then
  echo "继续执行"
elif [[ ${git_confirm} == 'n' ]];then
  exit 127
else
  echo "输入错误，脚本停止"
  exit 128
fi
git config credential.helper 'cache --timeout 0'
git config --global credential.helper 'cache --timeout 0'
git config --system credential.helper 'cache --timeout 0'
git config user.name  "${username[@]}"
git config user.email "${email[@]}"

echo "当前提交设置："
git config --list

echo "---------------进行提交----------------"
git add . -A
git commit -m "commit_message"
git push -u origin main