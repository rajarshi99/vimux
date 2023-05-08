#!/bin/sh

tmux list-panes -F "#{pane_id} #{pane_current_command}" \
	| grep 'zsh' \
	| awk '/[0-9]+/{ print $1 }' \
	| while read paneId; do
tmux select-pane -t $paneId
tmux send-keys ex
tmux send-keys it
tmux send-keys Enter
done
