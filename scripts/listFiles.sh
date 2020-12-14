#! /bin/bash
# This line (above) tells the system what to use to run this executable
# This is casually called the "sheh-bang" line

# In this script, I want to
# 1 - give novice users a few notes about bash scripts
# 2 - link the essential info that I am getting from 
#     the file name to the absolute path to the sample file.

# <- "hash" or "pound" is a comment character in bash, and in many file formats.

# GenMod is very reliant on relative paths.
# If you are running on the cluster, and PBS_O_WORKDIR is not ""
# then the script has been detached from its intended working directory, (PBS_O_WORKDIR)
# and you must cd back to it.
# This reads: if the number of characters in the value of the PBS_O_WORKDIR 
# variable is greater than 0, then change to that directory.
[ ${#PBS_O_WORKDIR} -gt 0 ] && cd $PBS_O_WORKDIR

# $1, $2, $3 - the first argument to this script is referenced as "$1", the second is $2 and so on
# Since these are remarkably undescriptive, its a good idea to describe the args a script takes.
# $1 - an absolute file path to an input file for this pipeline

# Standard out is sent to the log file
echo "Found $1"

# get the file name from the absolute path
# Common convention: variables are all-caps
NAME=$(basename $1)

# Cut out all the file-name-mouth-full.
# This page is my go-to resource for bash string maniputlation:
# https://tldp.org/LDP/abs/html/string-manipulation.html
NEW1=${NAME//BINF6350f2019/}
echo "NEW1: $NEW1"
NEW2=${NEW1//_S[0123456789]*_L001_R1_001.fastq/_R1.fastq}
echo "NEW2: $NEW2"
NEWNAME=${NEW2//_S[0123456789]*_L001_R2_001.fastq/_R2.fastq}
echo "NEWNAME: $NEWNAME"

# tack on a more generic file suffix so as not be mis-leading
OUT="$NEWNAME.txt"

# Create a file in this modules output with a name that includes the name 
# of the original input file, and that contains the absolute file path.
echo $1 > ../output/$OUT

# I like my logs to have an indication that the script reached the end
echo "done."
