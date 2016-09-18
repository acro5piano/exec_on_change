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

clear_console(){
    clear
    echo "exec      : $COMMAND"
    echo "at        : `date`"
    echo "on_change : $ON_CHANGE"
    echo "exclude   : $IGNORE_FILES"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

wait_for_change(){
    inotifywait --exclude $IGNORE_FILES -r -e MODIFY "$ON_CHANGE" 2>/dev/null || exit
}

check_requirements(){
    [ `which inotifywait` ] || die 'Please install inotify-tools'
}

check_args(){
    [ "$ON_CHANGE" ] || usage
    [ "$COMMAND" ] || usage
    [ -e "$ON_CHANGE" ] || die "No such file or directory: $ON_CHANGE"
}

start_watch(){
    clear_console
    while true; do
        wait_for_change
        clear_console
        $COMMAND
    done
}
