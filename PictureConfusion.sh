#!/bin/bash

# originPath must no be null
originPath=$1
if [ ! -n "$originPath" ];then
	echo "\033[31m\033[01myou must input picture resource path!!!\033[0m"
	exit
else
	echo "the picture resource path is $originPath"
fi


imageNumber=0
# echo total number : ${#fileArray[@]}
preString="pre_"
newPath="confuseResult"

# new result file path and cd into origin path
cd ..
mkdir $newPath
cd $originPath

files='*'
echo "files->$files"
fileArray=($files)

# copy picture resource
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