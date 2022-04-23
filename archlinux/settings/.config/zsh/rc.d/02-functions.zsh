#!/bin/zsh

##
# FZF Paru 
# Search and install packages with fzf
pi() { 
	SELECTED_PKGS="$(paru -Slq | fzf --header='Install packages' -m --preview 'paru -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		paru -S "$SELECTED_PKGS"
	fi
}

# Search and remove packages with fzf
pr() { 
	SELECTED_PKGS="$(paru -Qsq | fzf --header='Remove packages' -m --preview 'paru -Si {1}')"
	if [ -n "$SELECTED_PKGS" ]; then
		paru -Rns "$SELECTED_PKGS"
	fi
}
