KEY=$1
HERE=/home/rajarshi/.term
awk -v key=$KEY -v tmux=1 -f $HERE/cd.awk $HERE/place.txt | xargs tmux new-window -c
