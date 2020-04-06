#!/usr/bin/env bash

set -e

MAC_NOTIFIACTIONS=$1
PIDFILE_DIRECTORY="$HOME/.tmux/tmux-task-watcher"
PLATFORM="$(uname | tr '[:upper:]' '[:lower:]')"
# GNU default
GREP_COMMAND='grep -P'
[ "$PLATFORM" = "darwin" ] && GREP_COMMAND='grep -E'

# $1: The PID that needs to be watched
watch_command () {
    if [ "$PLATFORM" = "darwin" ]
    then
        lsof -p "$1" +r 1 &> /dev/null   
    else
        tail --pid=$1 -f /dev/null
    fi
}


# $1: The text to notify
notify_task () {
    if [ "$MAC_NOTIFIACTIONS" = "true" ]
    then
        osascript -e "display notification \"$1\" with title \"tmux-task-watcher\""
    else
        tmux display-message "$1"
    fi
}


# $1: The PID for the shell that _should_ be running the watch command
check_pid_exists () {
    ps  "$1" 2>&1 > /dev/null
    exists=$?
    # it exists
    [ "$exists" -eq "0" ] && pkill -P $1 && notify_task "Cancelled watch PID: $1" && check_pid_exists $1 && exit 0
    # assume any error code means it doesn't exist
    # delete the file and continue execution
    rm -f "$PIDFILE_DIRECTORY/PID"
}

mkdir -p $PIDFILE_DIRECTORY
[ -f "$PIDFILE_DIRECTORY/PID" ] && check_pid_exists $(cat "$PIDFILE_DIRECTORY/PID")

selected_pane_tuple=($(tmux list-panes -F '#{pane_active} #{pane_pid}' | grep "^1"))
pid_tuple=($(ps ax -o pid,ppid | $GREP_COMMAND "[0-9]+[[:space:]]+${selected_pane_tuple[1]}"))
child_pid=${pid_tuple[0]}
$(echo $BASHPID > "$PIDFILE_DIRECTORY/PID" && \
    watch_command $child_pid && \
    rm "$PIDFILE_DIRECTORY/PID" && \
    notify_task "PID: $child_pid finished") &
notify_task "Watching PID: $child_pid"

