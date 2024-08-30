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

# slurm shorthands
alias cancel='scancel --user=$(whoami)'
