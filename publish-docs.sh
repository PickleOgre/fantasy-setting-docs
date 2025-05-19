#!/usr/bin/env bash
function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0  ;;  
            [Nn]*) echo "Aborted" ; return  1 ;;
        esac
    done
}

echo "Syncing..."

source=source=$(cat source.txt)
rsync -av --delete $source /home/joe/projects/dakhoma-setting-docs/common_md


cd /home/joe/projects/dakhoma-setting-docs
git add .
git status

while true; do
    echo "Commit message:"
    read  message
    if [ -n "$message" ]; then 
	    git commit -m '$message'
        break
    else
    	echo "Please enter a commit message."
    fi
done

yes_or_no "Push changes?"
if [ $? -eq 0 ]; then 
	git push
else
	echo "Push cancelled. Diffs awaiting push."
fi