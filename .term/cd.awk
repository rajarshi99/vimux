# Essentially crammed two awk files into one
{ place[$1] = $2 }

(n = split($0, line, ".")) > 1 && !tmux {
	flag = 1
	printf("%s %s%s", key, home, line[2]);
	for(i=3;i<=n;i++) printf(".%s", line[i]);
	printf("\n")
}

END {
	if(!flag && !tmux) printf("cd %s\nkitty -e tmux\n", place[key])
	if(!flag && tmux) print place[key]
}
