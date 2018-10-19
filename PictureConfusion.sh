#!/bin/bash
imageNumber=0
files='*'
fileArray=($files)
# echo total number : ${#fileArray[@]}

for fileName in ${fileArray[@]}
do
	# echo $file
	if [ "${fileName##*.}" = "png" ] || [ "${fileName##*.}" = "PNG" ]  || [ "${fileName##*.}" = "jpg" ] || [ "${fileName##*.}" = "JPG" ] 
	then
		imageNumber=$[$imageNumber+1];
		cat $fileName > "pre_$fileName"
	fi

	if [ "${fileName##*.}" = "json" ]
	then
		echo "change Content.json"
	fi
done
echo "total ImageNumber: $imageNumber"