#!/bin/bash

# Run file quality checks on nanoAOD files.

usage() {
 echo "Usage: $0 [OPTIONS]"
 echo "Options:"
 echo " -N   Number of parallel jobs (default is 1 - this is a safety measure for long lists of files)"
 echo " -d   Give input directory"
 echo " -f   OR: Give input file txt file that contains FULL PATHS to files to be checked"
 echo " -o   Name of the file for writing bad file paths (default is output.txt)"
}

# Use root script to open files and scan over events
# At the moment this prints the full paths in the txt file
function checkfile() {

    root -l -b -q 'checkfile.C('\"$1\"')'
    
    if [ $? -ne 0 ]
    then
	echo "File " $1 " is bad"
	echo $1 >> $outfil
    else
	echo "File " $1 " is good"
    fi       
}


##### MAIN PART

if [ $# == 0 ]; then
    usage
    exit 1
fi

jobs=1
hasf=0
hasd=0
outfil=output.txt
while getopts "N:f:d:o:" flag; do
   case $flag in
   N)
       jobs=$OPTARG
       ;;
   f) 
       infil=$OPTARG
       hasf=1
       ;;
   d) 
       indir=$OPTARG
       hasd=1
       ;;
   o)
       outfil=$OPTARG
       ;;
   \?)
   # Handle invalid options
       usage
       exit 1    
       ;;
 esac
done

### Check if both f and d given
if (( hasf+hasd > 1 )); then
   echo "Use only -f or -d"
   exit 1
fi

if (( hasf+hasd < 1 )); then
    usage
   exit 1
fi

if (( hasd > 0 ))
    then
	ls $indir > filenames.txt
	infil=filenames.txt
	echo "Check files in directory "$indir
    else echo "Check files in file " $infil
fi


for filename_to_check in $(cat $infil); do

    if (( hasd > 0 ))
    then
	full_path=$indir'/'$filename_to_check
    else 
	full_path=$filename_to_check
    fi
    
   ((i=i%jobs)); ((i++==0)) && wait #  process stuff in batches of N - could be improved
    checkfile $full_path &

done
wait

rm filenames.txt

echo "Finished!"
