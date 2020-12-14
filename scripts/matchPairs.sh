#! /bin/bash

# No args.  This scripts looks for the ListFiles module.

# In case cluster job detached script from intended context
[ ${#PBS_O_WORKDIR} -gt 0 ] && cd $PBS_O_WORKDIR

# Find the ListFiles module in this pipeline
PIPE=$(dirname $(dirname $PWD))
INDIR=$(ls -d $PIPE/*_ListFiles/output)

OUT=../output/fileList.txt
# write a table header, -e makes "\t" turn into a tab
echo -e 'SAMPLE\tR1\tR2' > $OUT

# For each R1 file, create a metadata row with the 
# sample name, the R1 abs path and the R2 abs path.
# For eah R2 sample, do nothing, R1 handles it.
# For any non-fastq files, do nothing.
for BASE in $(ls $INDIR) 
do 
	echo $BASE
	SAMPLE=${BASE//_**/}
	echo $SAMPLE
	ABS=$(cat $INDIR/$BASE)
	echo $ABS
	if [[ "$ABS" == *R1_001.fastq* ]]
		then 
			echo 'This is the R1 file.'
			R1=$ABS
			R2=${R1//R1/R2}
			echo -e "$SAMPLE\t$R1\t$R2" >> $OUT
		fi
done

echo "done."
