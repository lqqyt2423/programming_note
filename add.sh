#!/bin/bash
set -o nounset
set -o errexit

title=
key=

while [ -z "$title" ]
do
  read -p "请输入文章标题: " title
done

generateKey() {
  while [ -z "$key" ]
  do
    read -p "请输入英文名称: " key
  done

  # 转换为小写
  key=$(echo $key | tr 'A-Z' 'a-z')
  # 替换空格为-
  key=$(echo $key | sed 's/[ ][ ]*/-/g')
  # 前面加日期，后面加文件类型
  key=$(date +%Y%m%d)-$key.md

  # 如果目录中存在此文件，提示且重复调用此函数
  if test -e $key
  then
    echo 文件${key}已存在，重新输入
    key=
    generateKey
  fi
}

generateKey

echo
echo 标题: ${title}
echo 文件名: ${key}

# 创建文件并向文件中写入标题
touch $key
echo -e "# $title\n" > $key

echo "done"
