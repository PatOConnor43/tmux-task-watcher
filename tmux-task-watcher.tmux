#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# $1: option
# $2: default value
tmux_get() {
    local value
    value="$(tmux show -gqv "$1")"
    [ -n "$value" ] && echo "$value" || echo "$2"
}
key="$(tmux_get '@tmux-task-watcher-key' 'W')"
mac_notifications="$(tmux_get '@tmux-task-watcher-mac-notifications' 'false')"

tmux bind-key $key run -b "$CURRENT_DIR/scripts/tmux-task-watcher.sh $mac_notifications"
