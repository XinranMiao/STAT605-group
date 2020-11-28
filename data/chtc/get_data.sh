#!/bin/bash

cat name.txt |tail -n +0 |head -n 126 > name_part_eval.txt

cat name_part_eval.txt | while read line
do
unzip /staging/groups/stat605_group6/NEW_data-eeg-age-v1.zip "$line" -d ./
done
