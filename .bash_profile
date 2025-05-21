
export PATH="$PATH:${HOME}/.local/bin"

export TERMINAL="st"
export EDITOR="nvim"
export BROWSER="firefox"

export JAVA_HOME=/usr/lib/jvm/default
export _JAVA_AWT_WM_NONREPARENTING=1
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
export XDG_CONFIG_HOME="${HOME}/.config"

source /usr/share/nvm/init-nvm.sh

[ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"

# eval "$(/usr/bin/ssh-agent -s)"
#/usr/bin/ssh-agent -s >> $HOME/.ssh/ssh-agent 2>> $HOME/.ssh/ssh-agent.err

if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	exec startx 2>> $HOME/.startx.err >> $HOME/.startx.out
fi
