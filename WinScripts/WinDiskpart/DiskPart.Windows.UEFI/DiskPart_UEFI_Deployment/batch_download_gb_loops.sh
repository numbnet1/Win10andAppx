#!/bin/bash
# Jacob Salmela
# 11 February 2014
# Updated: 2015-05-12
# https://github.com/jacobsalmela
	
# Copy ALPIndex.app into /Applications on each machine that the script will run on

#----------VARIABLES---------	
# Variable to store the location of the ALPIndex binary, which is inside the .app bundle
indexLoops="/Applications/ALPIndex.app/Contents/MacOS/ALPIndex"
localIndicies="/Library/Audio/Apple Loops Index"
loopsLocation="/Library/Audio/Apple Loops/Apple"
supportDir="/Library/Application Support/Hopkins"

#---------FUNCTIONS----------
function getRequiredLoopList()
	{
	if [[ -f "$supportDir"/requiredLoops.txt ]];then
		updateNeeded=$(curl -s -z "$supportDir"/requiredLoops.txt https://raw.githubusercontent.com/jacobsalmela/re-index-garageband-loops/master/requiredLoops.txt)
		if [[ -n "$updateNeeded" ]];then
			echo "Downloading updated loops list..."
			echo ""
			curl -s -o "$supportDir"/requiredLoops.txt https://raw.githubusercontent.com/jacobsalmela/re-index-garageband-loops/master/requiredLoops.txt
			requiredLoops=$(cat "$supportDir"/requiredLoops.txt | wc -l | sed 's/^[ \t]*//')
		else
			echo "Required loop list has not been updated."
			echo ""
		fi
		requiredLoops=$(cat "$supportDir"/requiredLoops.txt | wc -l | sed 's/^[ \t]*//')
	else
		echo "Downloading loops list..."
		echo ""
		curl -s -o "$supportDir"/requiredLoops.txt https://raw.githubusercontent.com/jacobsalmela/re-index-garageband-loops/master/requiredLoops.txt
		requiredLoops=$(cat "$supportDir"/requiredLoops.txt | wc -l | sed 's/^[ \t]*//')
	fi
	}
	
#----------SCRIPT------------
if [[ -d "$supportDir" ]];then
	getRequiredLoopList
else
	echo "Cresting Application Support directory..."
	mkdir "$supportDir"
	getRequiredLoopList
fi

echo "** Removing bad index files..."
rm -rf "$localIndicies"/*

# Index each collection of loops
for loopCollection in "$loopsLocation"/*; do
	collectionName=$(echo "$loopCollection" | awk -F'/' '{print $NF}')
	printf "** Indexing: $collectionName..."
 	$indexLoops "$loopsLocation"/"$collectionName" &>/dev/null
 	if [[ $? = 0 ]];then
 		printf "...success\n"
 	else
		printf "...failure\n"
 	fi
done
echo ""

# List how many compilations were indexed
#$indexLoops -p | awk -F'/' '{print $NF}' | cut -d'"' -f-1 | sort
$indexLoops -p | grep 'Total number of indexed directories'

# http://stackoverflow.com/questions/1767384/ls-command-how-can-i-get-a-recursive-full-path-listing-one-line-per-file
ls -R "$loopsLocation" | awk '/:$/&&f{s=$0;f=0}/:$/&&!f{sub(/:$/,"");s=$0;f=1;next}NF&&f{ print s"/"$0 }' | sed 's/^[ \t]*//' > "$supportDir"/installedLoops.txt

installedLoops=$(cat "$supportDir"/installedLoops.txt | wc -l | sed 's/^[ \t]*//')
echo ""
echo "INSTALLED loops: $installedLoops"
echo "REQUIRED  loops: $requiredLoops"
echo ""
if [[ $requiredLoops != $installedLoops ]];then
	difference=$(($requiredLoops - $installedLoops))
	echo "$difference loops are missing:"
	echo ""
	diff "$supportDir"/requiredLoops.txt "$supportDir"/installedLoops.txt | awk -F'[<>]' '{print $2}' | sed -e 's/^[ \t]*//' | sed '/^$/d'
else
	echo "All loops are installed."
fi