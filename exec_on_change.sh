#!/bin/bash

exec_on_change(){
    BIN_DIR="$(cd `dirname $0`; pwd)"
    ROOT_DIR="`dirname $BIN_DIR`"
    IGNORE_FILES=$(cat $ROOT_DIR/exclude.txt | tr \\n \| | sed 's/|$//')
    ON_CHANGE=$1
    COMMAND=$2

    source $ROOT_DIR/src/exec_on_change.sh
    source $ROOT_DIR/src/init.sh

    check_requirements
    check_args

    clear_console
    while true; do
        wait_for_change
        clear_console
        $COMMAND
    done
}
