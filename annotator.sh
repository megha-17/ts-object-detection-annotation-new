#!/bin/bash   
echo "Enter path of your data folder"
read data

jq -n "{labels: [],imageURLs: [],annotationURLs: []}" > $data/example.json


for file in $data/images/*; do

   jq --arg imageURLs "data/images/""${file##*/}" '.imageURLs|=.+[$imageURLs]' $data/example.json>$data/temp.json
   cp $data/temp.json $data/example.json 
   filenamewithextension="${file##*/}"
   jq --arg annotationURLs "data/annotations/""${filenamewithextension%.*}"".png" '.annotationURLs|=.+[$annotationURLs]' $data/example.json>$data/temp.json
   cp $data/temp.json $data/example.json 
   
done

jq --slurpfile labels $data/labels.txt '.labels=$labels' $data/example.json>$data/temp.json
cp  $data/temp.json $data/example.json 
rm $data/temp.json



