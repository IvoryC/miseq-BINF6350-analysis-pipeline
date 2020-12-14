#! /bin/bash

# $1 - the name of a file in the ListFiles modules, the file contains the absolute path
# $2 - Path to fastqc that is ued IFF fasqc is not on the PATH.

# As a ForEachFile module, BioLockJ handles finding the files.
# Alternatively, 
# This could be a simple GenMod, and it would find the ListFiles module
# PIPE=$(dirname $(dirname $PWD))
# INDIR=$(ls -d $PIPE/*_ListFiles/output)
# for BASE in $(ls $INDIR); do INSERT STUFF HERE; done 

# In case cluster job detached script from intended context
[ ${#PBS_O_WORKDIR} -gt 0 ] && cd $PBS_O_WORKDIR

# If fastqc is on the path, use it.  
# Otherwise, take arg 2 as the path to the executable
fastqcExe=$(which fastqc) || fastqcExe=$2
$fastqcExe --version

# If the file given in the first arg ends in .fastq or .fastq.gz, 
# then use that as the sequence file path.
# Otherwise, read the file and use its contents as the file path.
[[ "$1" == *".fastq.gz" ]] && FQ=$1 
[[ "$1" == *".fastq" ]] && FQ=$1 
[[ "$1" == *".txt" ]]  && FQ=$(cat $1)
[[ ${#FQ} -eq 0 ]] && echo "Failed to determine sequence file from arg: $1" && exit 1

echo "Given file: $1"
echo "Sequence file path is: $FQ"

$fastqcExe $FQ --dir ../temp --outdir ../output

echo "done."
