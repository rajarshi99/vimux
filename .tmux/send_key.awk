BEGIN { prefix="tmux send-keys -t" }

flag = $1 ~ /.?:[0-9]\.[0-9]/ && key = keys[$2] { print prefix, $1, key }

!flag { cmd_name = $1 ; $1 = "" ; keys[cmd_name] = $0 }
