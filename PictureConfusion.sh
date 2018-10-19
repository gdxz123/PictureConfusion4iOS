#!/bin/bash

# originPath must no be null
originPath=$1
if [ ! -n "$originPath" ];then
	echo "\033[31m\033[01myou must input picture resource path!!!\033[0m"
	exit
fi

cd $originPath

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

imageArray=()

# copy files
for fileName in ${fileArray[@]}
do
	# copy picture resource
	if [ "${fileName##*.}" = "png" ] || [ "${fileName##*.}" = "PNG" ]  || [ "${fileName##*.}" = "jpg" ] || [ "${fileName##*.}" = "JPG" ] 
	then
		cat $fileName > "../$newPath/$preString$fileName"
		imageArray[imageNumber]=$fileName
		imageNumber=$[$imageNumber+1];
	fi

	# copy Contents.json
	if [ "$fileName" = "Contents.json" ]
	then
		cat $fileName > "../$newPath/$fileName"
		for imageName in ${imageArray[@]}
		do
			sed "s/$imageName/$preString$imageName/g" $fileName > ../$newPath/$fileName
		done
	fi
done
# echo "total ImageNumber: $imageNumber"