#!/bin/bash

# originPath must no be null
originPath=$1
if [ ! -n "$originPath" ];then
	echo "\033[31m\033[01myou must input picture resource path!!!\033[0m"
	exit
fi

cd $originPath


# setting
preString="pre_"
newPath="confuseResult"
propertyName="Contents.json"

# new result file path and cd into origin path
cd ..
mkdir $newPath
cd $originPath

checkFiles() {
	currentPath=$1
	files='*'
	fileArray=($files)

	imageNumber=0
	imageArray=()

	# copy files
	for fileName in ${fileArray[@]}
	do
		# copy picture resource
		if [ "${fileName##*.}" = "png" ] || [ "${fileName##*.}" = "PNG" ]  || [ "${fileName##*.}" = "jpg" ] || [ "${fileName##*.}" = "JPG" ] 
		then
			cat $fileName > "../$newPath/$preString$fileName"
			imageArray[imageNumber]=$fileName
			imageNumber=$[$imageNumber+1]
		fi

		# copy Contents.json
		if [ "$fileName" = "$propertyName" ]
		then
			# echo $imageNumber
			cat $fileName > "../$newPath/$propertyName"
		fi

		# copy Folder
		if [ -d $fileName ]
		then
			mkdir "../$newPath/$fileName"
		fi
	done

	# Change Contents.json content
	if [ -f "../$newPath/$propertyName" ]
	then
		# if Contents.json is image property json
		if cat "../$newPath/$propertyName" | grep "images">/dev/null
		then
			for imageName in ${imageArray[@]}
			do
				sed -i "" "s/$imageName/$preString$imageName/g" "../$newPath/$propertyName"
			done
		fi
	fi
	
}

checkFiles ${originPath}


















