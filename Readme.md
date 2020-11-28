STAT605 Project

## Members:

Zihang Wang, zwang2547

Jie Sheng, jsheng27

Haoran Lu, hlu226

Luyang Fang, lfang45

Xinran Miao, xmiao27

## Parallel ICA:
In order to run ICA via CHTC, you'll need to:
1. Create a file with lines specifying the file name (`file.txt`).
2. Put `chtc/name.txt`, `chtc/get_data.sh`,`chtc/test.sh`, `chtc/test.sub`, `chtc/test.R` and `chtc/*.tar.gz`  in your working directory. Create directories `output`, `error` an `log`.
3. Change the lines in `chtc/get_data.sh` to make sure you get a name list that you want. Say we get the output file named `name_part_eval.txt`, then run `cat name_part_eval.txt | cut -d/ -f4 > name_eval.txt` to get a list o file names.
4. Change the directory in `chtc/test.sub` of getting .csv files into your directory.
5. Run `condor_submit test.sub`.
