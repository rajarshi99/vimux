KEY=$1
HERE=/home/rajarshi/.term
awk -v key=$KEY -f $HERE/cd.awk $HERE/place.txt | sh
