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

MY_SAVEIFS=$IFS
#IFS=$(echo -en "\n\b")
IFS=$'\n'

function recursiveCheckFiles() {

	imageNumber=0
	imageArray=()

	fileArray=$(ls $1)
	# copy files
	for fileName in ${fileArray[*]}
	do
		# copy file resource
		if [ -f $1/$fileName ]; then
			if [ "${fileName##*.}" = "png" ] || [ "${fileName##*.}" = "PNG" ]  || [ "${fileName##*.}" = "jpg" ] || [ "${fileName##*.}" = "JPG" ]; then
				if [ ! -f $2/$preString$fileName ]; then
					cp $1/$fileName $2/$preString$fileName
					imageArray[imageNumber]=$fileName
					imageNumber=$[$imageNumber+1]
				fi
			# copy Contents.json
			elif [ $fileName = $propertyName ]; then
				if [ ! -f $2/$fileName ]; then
					cat $1/$fileName > $2/$propertyName
				fi
			else
				if [ ! -f $2/$fileName ]; then
					cp $1/$fileName $2/$fileName
				fi
			fi
		# copy Folder rescource
		elif [ -d $1/$fileName ]; then
			if [ ! -d $2/$fileName ]; then
				mkdir -p $2/$fileName
			fi
			recursiveCheckFiles $1/$fileName $2/$fileName
		else
			echo "333$fileName"
		fi

	done

	# Change Contents.json content
	if [ -f $2/$propertyName ]; then
		# if Contents.json is image property json
		if cat $2/$propertyName | grep "\"images\"">/dev/null; then
			for imageName in ${imageArray[@]}
			do
				sed -i "" "s/\"$imageName\"/\"$preString$imageName\"/g" "$2/$propertyName"
			done
		fi
	fi
}

dest_dir="$originPath/../confusionResult"
recursiveCheckFiles $originPath $dest_dir