#
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

. "${HOME}/.shell/aliases"
. "${HOME}/.shell/extra"
. "${HOME}/.shell/prompt"
