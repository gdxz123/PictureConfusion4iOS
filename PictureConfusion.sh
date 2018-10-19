#!/bin/bash
imageNumber=0
files='*'
fileArray=($files)
# echo total number : ${#fileArray[@]}
preString="pre_"
newPath="confuseResult"

originPath=$1

if [ ! -n "$originPath" ];then
	echo "\033[31m\033[01myou must input picture resource path!!!\033[0m"
	exit
else
	echo "the picture resource path is $originPath"
fi

cd ..
mkdir $newPath
cd $originPath

for fileName in ${fileArray[@]}
do
	# echo $file
	if [ "${fileName##*.}" = "png" ] || [ "${fileName##*.}" = "PNG" ]  || [ "${fileName##*.}" = "jpg" ] || [ "${fileName##*.}" = "JPG" ] 
	then
		imageNumber=$[$imageNumber+1];
		cat $fileName > "../$newPath/$preString$fileName"
	fi

	if [ "${fileName##*.}" = "json" ]
	then
		echo "change Content.json"
	fi
done
echo "total ImageNumber: $imageNumber"