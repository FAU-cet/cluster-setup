# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

PS1='\[\e[0;93m\]\A \[\e[0m\]- \[\e[0;94m\]\u\[\e[0m\]@\[\e[0;38;5;202m\]\h \[\e[0m\][\[\e[0;92m\]\w\[\e[0m\]]\n\[\e[0m\]> \[\e[0m\]'

alias ls='ls --color=auto'
alias ll='ls -lhv'
alias la='ls -lahv'

alias py='python3'

# go up a variable number of directories
function cu {
    local count=$1
    if [ -z "${count}" ]; then
        count=1
    fi
    local path=""
    for i in $(seq 1 ${count}); do
        path="${path}../"
    done
    cd $path
}

# make a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

alias ml='module load'
alias ma='module avail'
alias mu='module unload'

# slurm shorthands
alias cancel='scancel --user=$(whoami)'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

