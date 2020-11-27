#!/bin/bash

cat name.txt |tail -n +327 |head -n 200 > name_part.txt

cat name_part.txt | while read line
do
unzip /staging/groups/stat605_group6/NEW_data-eeg-age-v1.zip "$line" -d ./
done