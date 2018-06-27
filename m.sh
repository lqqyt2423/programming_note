#! /bin/sh

while [ -z "$title" ]
do
  read -p "Enter title: " title
done

generateKey() {
  while [ -z "$key" ]
  do
    read -p "Enter key: " key
  done

  # 转换为小写
  key=$(echo $key | tr 'A-Z' 'a-z')
  # 替换空格为-
  key=$(echo $key | sed 's/[ ][ ]*/-/g')
  # 前面加日期，后面加文件类型
  key=$(date +%Y%m%d)-$key.md

  # 如果目录中存在此文件，提示且重复调用此函数
  [ -e $key ] && echo "The file $key existed, please change the key you input" && unset key && generateKey
}

generateKey

# 字符长度
# echo ${#key}

# 创建文件并向文件中写入标题
touch $key
echo "# $title\n" > $key

echo "\nGenerated the file:"
echo $key
