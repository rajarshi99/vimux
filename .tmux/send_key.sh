#!/bin/sh

tmux list-panes -a -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}' \
	| awk -f ~/.tmux/send_key.awk ~/.tmux/exit_codes.txt - \
	| sh

