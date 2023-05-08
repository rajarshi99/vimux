#!/bin/sh

echo "\nBackground sessions started"
command -V cmus > /dev/null && tmux new-session -s music -d 'cmus'
# command -V ranger > /dev/null && tmux new-session -s shelz -d 'ranger'
tmux attach
# if command -V fzf > /dev/null ; then
# 	find . -type d | fzf | xargs tmux new-window -c
# 	tmux attach
# else
# 	tmux new-window
# fi
