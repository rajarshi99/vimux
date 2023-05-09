KEY=$1
HERE=/home/rajarshi/.term
cd $HOME
find . -not -path '*/.*' -type d \
	| fzf --bind=tab:up,btab:down \
	| awk -v key=$KEY -v home="/home/rajarshi" -f $HERE/cd.awk \
	>> $HERE/place.txt
awk -v key=$KEY -v tmux=1 -f $HERE/cd.awk $HERE/place.txt | xargs tmux new-window -c
