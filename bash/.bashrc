# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

svndiff()
{
  svn diff --diff-cmd='meld' $1
}



# added by Anaconda2 4.3.0 installer
export PATH="/home/simplex/anaconda2/bin:$PATH"

# GNU Global
export LESSGLOBALTAGS=global
export GTAGSCONF=/usr/local/share/gtags/gtags.conf
export GTAGSLABEL=pygments








# Prompt
# PS1='\[\033[0;36m\]╔═(\[\033[0m\033[0;36m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\033[0;36m\])────(\[\033[0m\]\t \d\[\033[0;36m\])────(\[\033[0m\]\w\[\033[0;36m\])\n\[\033[0;36m\]╚═══[ \[\033[0m\033[0;36m\]\$\[\033[0m\033[0;36m\]]>\[\033[0m\] '

export PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'


# java -jar plantuml.jar -tsvg sequenceDiagram.txt
alias plantuml='java -jar plantuml.jar '
