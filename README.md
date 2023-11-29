Scripts for checkign quality of transferred nanoAOD files - why not other root files as well. (Slowness in the transfer process sometimes causes corruption of the root files.)


checkquality.sh: bash scrips for checking either all files in a directory or paths to files listed in a .txt/an ascii file

checkfiles.C: root script that tries opening and scans over a NANOAOD file (= a file that contains a TTree called "Events" - hardcoded at the moment)

Suggested workflow:
1. Download files (using copyviaproxy.py)
2. Run this check over the folder, e.g.:
   bash checkquality.sh -N 10 -d /path/to/folder/to/check/ -o outputfile.txt
3. Remove or move files listed in outputfile.txt (no script provided at the moment)
4. Re-download removed files (copyviaproxy is intelligent enough to download only missig files)
5. Run the check using the previous output:
   bash checkquality.sh -N 10 -f outputfile.txt -o outputfile_v2.txt