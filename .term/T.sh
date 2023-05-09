KEY=$1
HERE=/home/rajarshi/.term
find . -not -path '*/.*' -type d \
	| rofi -dmenu -i \
	| awk -v key=$KEY -v home="/home/rajarshi" -f $HERE/cd.awk \
	>> $HERE/place.txt
awk -v key=$KEY -f $HERE/cd.awk $HERE/place.txt | sh
