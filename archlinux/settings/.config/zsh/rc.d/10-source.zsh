#!/bin/zsh

# Sources from applications

# Loads FZF keybindings, replacing native reverse search etc with FZF
[[ -e "/usr/share/fzf/key-bindings.zsh" ]] \
  && source "/usr/share/fzf/key-bindings.zsh"

eval "$(zoxide init zsh --cmd j --no-aliases)"

alias j="__zoxide_zi"