#!/bin/bash

usage(){
    echo "Usage:"
    echo "    exec_on_change file command"
    exit 1
}

die(){
    echo $1
    exit 2
}

[ `which inotifywait` ] || die 'Please install inotify-tools'
[ $# -lt 2 ] && usage
[ -e "$1" ] || die "No such file or directory: $1"

ignore_files=$(cat exclude.txt | tr \\n \|)

while [ 1 ]; do
    clear
    inotifywait --exclude $ignore_files -r -e MODIFY "$1" 2>/dev/null || exit
    $2
done

