#! /bin/bash

# $1 - first arg is a sample name, should match first column in MatchPairs/output/fileList.txt
# $2 - Path to rdp jar file

# In case cluster job detached script from intended context
[ ${#PBS_O_WORKDIR} -gt 0 ] && cd $PBS_O_WORKDIR

# Find the Merge module in this pipeline
PIPE=$(dirname $(dirname $PWD))
FQ=$(ls -d $PIPE/*_Merge/output/$1*)

OUTDIR=$(dirname $PWD)/output

# The RDP classifier is not on the path; it is invoked through a java call.  
# Does this jar file exist (the docker container RDP file) ? -- if so, use it.
# Otherwise, take arg 2 as the path to the executable
RDP=/app/classifier.jar
java -jar $RDP --help || RDP=$2 && java -jar $RDP --help
echo "Using RDP jar file found at: $RDP"

java -jar $RDP --hier_outfile $OUTDIR/$1_hierCounts.txt -o $OUTDIR/$1_reported.txt $FQ

echo done.
