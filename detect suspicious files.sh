#!/bin/bash

# Set variables for directories to search and files to look for
search_dirs="/var/log /etc"
suspicious_files="*.txt *.log"

# Search for files in the specified directories that match the suspicious files pattern
find $search_dirs -name "$suspicious_files" -print

# Use grep to search for keywords within the files found in the previous step
grep -iE "error|warning|fail|denied|unauthorized|critical" $(find $search_dirs -name "$suspicious_files")
