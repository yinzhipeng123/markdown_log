#!/bin/bash
# 获取脚本的当前所在位置
clear_code_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cd "${clear_code_path}" || exit

echo "当前程序执行所在目录为：$(pwd)"

read -p "请确认当前所在目录，是否修改　$(pwd) 下文件，输入y，继续执行，输入n，停止执行：" confirm

if [[ ${confirm} == 'y' ]] ;then
  echo "继续执行"
elif [[ ${confirm} == 'n' ]];then
  exit 127
else
  echo "输入错误，脚本停止"
  exit 128
fi

cat venv/lib/python3.8/site-packages/material/base.html | grep busuanzi
if [[ $? = 0 ]];
then
  echo "已添加访问量统计"
else
  # venv需要放在markdown_log目录下
  sed -i "" "s/<\/article>/<hr><span id=\"busuanzi_container_page_pv\"><font size=\"3\" color=\"grey\">本文总阅读量<span id=\"本文总阅读量_value_page_pv\"><\/span>次<\/font><\/span><br\/><\/article>/g"  venv/lib/python3.8/site-packages/material/base.html
  echo "添加完成"
fi


cp docs/javascripts/disqus.html venv/lib/python3.8/site-packages/material/partials/integrations/disqus.html