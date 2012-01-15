# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PS1='\[\e[0;31m\]\u\[\e[m\]@\[\e[1;34m\]\h \w\[\e[m\]\[\e[0;31m\]\$ \[\e[m\]'
PATH=$PATH:/home/wanglei/bin
export PATH

# My own alias

alias ls='ls --color=always'
alias ll='ls -lhpFa'
alias l='ls'
alias du='du -h'
alias grep='grep --color=always'
alias less='less -FR'

# enhance bash completion
# . /etc/bash_completion_lib/bash_completion_lib
alias emacs='emacs -l ~/repos/emacs-confs/.emacs'
