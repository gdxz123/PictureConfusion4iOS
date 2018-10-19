#!/bin/bash

# originPath must no be null
originPath=$1
cd $originPath
if [ ! -n "$originPath" ];then
	echo "\033[31m\033[01myou must input picture resource path!!!\033[0m"
	exit
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
fileArray=($files)

# copy files
for fileName in ${fileArray[@]}
do
	# copy picture resource
	if [ "${fileName##*.}" = "png" ] || [ "${fileName##*.}" = "PNG" ]  || [ "${fileName##*.}" = "jpg" ] || [ "${fileName##*.}" = "JPG" ] 
	then
		imageNumber=$[$imageNumber+1];
		cat $fileName > "../$newPath/$preString$fileName"
	fi

	# copy Contents.json
	if [ "$fileName" = "Contents.json" ]
	then
		echo "change Content.json"
	fi
done
# echo "total ImageNumber: $imageNumber"