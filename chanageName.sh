#!bin/sh

CurrentDir=`dirname $0`
echo $CurrentDir
cd $CurrentDir

# 提取文件名
for file in `ls -a`
do 
    # 提取@2X之前的内容
    local tempFileName=${var%%@*}
    echo $tempFileName
done
# ch2py修改文件名

# 更改文件