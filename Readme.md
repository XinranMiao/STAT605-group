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
2. Put `file.txt`, `chtc/test.sh`, `chtc/test.sub`, `chtc/fastICA_1.2-2.tar.gz` and `ica.R` in your working directory.
3. Change the directory in `chtc/test.sub` of getting .csv files into your directory.
4. Run `condor_submit test.sub`.
