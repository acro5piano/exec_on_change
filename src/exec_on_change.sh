#!/bin/bash

exec_on_change::usage(){
    echo "Usage:"
    echo "    exec_on_change file command"
    exit 1
}

exec_on_change::die(){
    echo $1
    exit 2
}

exec_on_change::clear_console(){
    clear
    echo "exec      : $COMMAND"
    echo "at        : `date`"
    echo "on_change : $ON_CHANGE"
    echo "exclude   : $IGNORE_FILES"
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
}

exec_on_change::wait_for_change(){
    inotifywait --exclude $IGNORE_FILES -r -e MODIFY "$ON_CHANGE" 2>/dev/null || exit
}

exec_on_change::check_requirements(){
    [ `which inotifywait` ] || exec_on_change::die 'Please install inotify-tools'
}

exec_on_change::check_args(){
    [ "$ON_CHANGE" ] || exec_on_change::usage
    [ "$COMMAND" ] || exec_on_change::usage
    [ -e "$ON_CHANGE" ] || exec_on_change::die "No such file or directory: $ON_CHANGE"
}

exec_on_change::start_watch(){
    exec_on_change::clear_console
    while true; do
        exec_on_change::wait_for_change
        exec_on_change::clear_console
        $COMMAND
    done
}
