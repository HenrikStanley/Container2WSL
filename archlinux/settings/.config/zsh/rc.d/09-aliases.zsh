#!/bin/zsh

# Aliases

# File related commands
alias cat="bat -p"
alias caty="bat -p -l yaml"
alias -g OY="-oyaml | caty"

# Exa
alias l="exa --long --header --all --sort type --git"
alias ls="exa --long --header --all --sort type --git --group"