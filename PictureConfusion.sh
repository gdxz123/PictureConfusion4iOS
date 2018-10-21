#!/bin/bash

# originPath must no be null
originPath=$1
if [ ! -n "$originPath" ]; then
	echo "\033[31m\033[01myou must input picture resource path!!!\033[0m"
	exit
fi

# setting
preString="pre_"
newPath="confuseResult"
propertyName="Contents.json"

function recursiveCheckFiles() {
	sourcePath=$1
	targetPath=$2
	fileArray=$(ls $sourcePath)

	imageNumber=0
	imageArray=()

	# copy files
	for fileName in ${fileArray[*]}
	do
		# copy file resource
		if [ -f $sourcePath/$fileName ]; then
			if [ "${fileName##*.}" = "png" ] || [ "${fileName##*.}" = "PNG" ]  || [ "${fileName##*.}" = "jpg" ] || [ "${fileName##*.}" = "JPG" ]; then
				cat $fileName > "$targetPath/$preString$fileName"
				imageArray[imageNumber]=$fileName
				imageNumber=$[$imageNumber+1]
			# copy Contents.json
			elif [ "$fileName" = "$propertyName" ]; then
				if [ ! -f $targetPath/$fileName ]; then
					cat $sourcePath/$fileName > $targetPath/$propertyName
				fi
			else
				if [ ! -f $targetPath/$fileName ]; then
					cp $sourcePath/$fileName $targetPath/$fileName
				fi
			fi
		# copy Folder rescource
		elif [ -d $sourcePath/$fileName ]; then
			echo $sourcePath/$fileName
			if [ ! -d $targetPath/$fileName ]; then
				mkdir -p $targetPath/$fileName
			fi
			recursiveCheckFiles $sourcePath/$fileName $targetPath/$fileName
		fi
	done

	# Change Contents.json content
	if [ -f "$targetPath/$propertyName" ]; then
		# if Contents.json is image property json
		if cat "$targetPath/$propertyName" | grep "images">/dev/null; then
			for imageName in ${imageArray[@]}
			do
				sed -i "" "s/\"$imageName\"/\"$preString$imageName\"/g" "$targetPath/$propertyName"
			done
		fi
	fi
}

recursiveCheckFiles $originPath $originPath/../$newPath


















