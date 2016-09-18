exec_on_change(){
    ROOT_DIR="$(cd `dirname $0`; pwd)"
    IGNORE_FILES=$(cat $ROOT_DIR/exclude.txt | tr \\n \| | sed 's/|$//')
    ON_CHANGE=$1
    COMMAND=$2

    source $ROOT_DIR/src/exec_on_change.sh
    source $ROOT_DIR/src/init.sh

    check_requirements
    check_args
    start_watch
}
