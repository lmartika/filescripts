Scripts for checkign quality of transferred nanoAOD files - why not other root files as well. (Slowness in the transfer process sometimes causes corruption of the root files.)


checkquality.sh: bash scrips for checking either all files in a directory or paths to files listed in a .txt/an ascii file

checkfiles.C: root script that tries opening and scans over a NANOAOD file (= a file that contains a TTree called "Events" - hardcoded at the moment)