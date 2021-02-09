function repeat {
	re='^[0-9]+$'
	if [ "$#" -ne 2 ] || ! [[ $2 =~ $re ]]; then
		echo "Usage: $0 \"<cmd> [opts]\"  <number>" >&2
		return 1
	fi
	i=1
	while [[ $i -le $2 ]]
	do
		eval $1
		((i = i + 1))
	done
}

function monag {
	
	if [ "$#" -ne 2 ] ; then
		echo "Usage: $0 inputfile outputfile" >&2
		return 1
	fi
	mona -gw $1 | dot -Tps -o $2
	xo $2
}

function alarmer {
	if [ $# -eq 1 ]; then
		sleep $(($(date -d "$1" +%s) - $(date +%s)))
		playerctl --player=spotify pause
		paplay /usr/share/sounds/ubuntu/notifications/Mallet.ogg
		notify-send "Time to go!"
	elif [ $# -eq 2 ]; then
		sleep $(($(date -d "$1" +%s) - $(date +%s)))
		playerctl --player=spotify pause
		paplay /usr/share/sounds/ubuntu/notifications/Mallet.ogg
		notify-send "$2"
	else
		echo "Usage: $0 [alarm time] (message)"
	fi
}

function dotfiler {
	if [[ $# -eq 1 ]] && [[ -d "$HOME/.dotfiles" ]] && [[ -f "$1" ]] || [[ -d "$1" ]]
	then
		pth=$(realpath -s --relative-to="$HOME" "$1")
		dr=$(dirname "$pth")
		if [[ -L "$1" ]] && ([[ -f "$HOME/.dotfiles/$pth" ]] || [[ -d "$HOME/.dotfiles/$pth" ]])
		then
			echo "Dotfile already exists at $HOME/.dotfiles/$pth"
			return 1
		fi
		mkdir -p "$HOME/.dotfiles/$dr"
		mv "$1" "$HOME/.dotfiles/$pth"
		ln -s "$HOME/.dotfiles/$pth" "$1"
	else
		echo "Usage: $0 [file]"
	fi
}
