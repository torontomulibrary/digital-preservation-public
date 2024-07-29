#!/bin/bash

# sets the Internal Field Separator to new line only so it doesn't separate based on spaces (read more here: https://delightlylinux.wordpress.com/2020/02/16/bash-ifs-what-is-the-internal-field-separator/)
IFS=$'\n'

# whatever is in quotes is the container you want to delete objects from
declare con="transfersource" 

# exports a list of all the objects in the container as a txt file
swift list ${con} > deleted-objects.txt

# variable declaration for the txt file
declare -x list="deleted-objects.txt"

# variable declaration to parse the first 10000 lines of the txt file
declare -a shrtlst=$(head -n10000 ${list})

# command that deletes objects based off of the given variables
swift delete ${con} ${shrtlst}

# for custom list do swift list transfersource > deleted-objects.txt and edit that txt file, then comment out line 10 (note it might still leave some leftover files if files have similar names (eg. if you uploaded several duplicates of the same transfer) but usually those leftover files are small in number and can be deleted via the Horizon interface)