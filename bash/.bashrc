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
# temp export PATH="/home/simplex/anaconda2/bin:$PATH"

# GNU Global
export LESSGLOBALTAGS=global
export GTAGSCONF=/usr/local/share/gtags/gtags.conf
export GTAGSLABEL=pygments


# export QUARTUS_VERSION=16.1
export QUARTUS_VERSION=17.0
# Used for contract with TCL scripts
export QUARTUS=/home/simplex/eda/intelFPGA/${QUARTUS_VERSION}


export MODELSIM=/home/simplex/eda/intelFPGA/16.1/modelsim_ae


# export LM_LICENSE_FILE=27000@offfile3.s MGLS_LICENSE_FILE=27000@offfile3.s
export LM_LICENSE_FILE=27000@offfile3.s

# export PATH=$PATH:/home/simplex/eda/intelFPGA/16.1/quartus/bin/
export PATH=$PATH:${QUARTUS}/quartus/bin::${QUARTUS}/quartus/sopc_builder/bin:${MODELSIM}/bin

# Prompt
# PS1='\[\033[0;36m\]╔═(\[\033[0m\033[0;36m\]\u\[\033[0m\]@\[\033[0;32m\]\h\[\033[0m\033[0;36m\])────(\[\033[0m\]\t \d\[\033[0;36m\])────(\[\033[0m\]\w\[\033[0;36m\])\n\[\033[0;36m\]╚═══[ \[\033[0m\033[0;36m\]\$\[\033[0m\033[0;36m\]]>\[\033[0m\] '

export PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'


# java -jar plantuml.jar -tsvg sequenceDiagram.txt
alias plantuml='java -jar /home/simplex/bin/plantuml.jar '

export MODULEPATH=${MODULEPATH}:/home/simplex/modulefiles:/home/simplex/git/simplex/fpga/modulefiles

alias quartus_sh="rlwrap \quartus_sh "


# module load py36/i686
# alias python=`which python3.6`

# export LD_LIBRARY_PATH=/opt/python32/lib:/home/simplex/git/cocotb/build/libs/i686:${LD_LIBRARY_PATH}
# PYTHONPATH=/opt/python32/lib/python3.6/site-packages/ LD_LIBRARY_PATH=/opt/python32/lib:/home/simplex/git/cocotb/build/libs/i686:${LD_LIBRARY_PATH} SIM=modelsim ARCH=i686 make

# PYTHONPATH=/opt/python32/lib/python3.6/site-packages/ LD_LIBRARY_PATH=/opt/python32/lib:/home/simplex/git/cocotb/build/libs/i686:${LD_LIBRARY_PATH} SIM=modelsim ARCH=i686 make

# Go in py36 module ==> PYTHONPATH=/opt/python32/lib/python3.6/site-packages/ 
# /opt/python32/lib is in /etc/ld.so.conf.d/libc.conf may be should be in module py36
# 

# Python 32
# Refactor py36 to python32 and python64

# Cocotb
# Make cocotb module including SIM_ROOT, SIM, and ARCH. Also, require python32.
# put on alias for python like above.  Change prompt to include (cocotb) and directory name.
# export SIM_ROOT=/home/simplex/git/cocotb
# LD_LIBRARY_PATH=/home/simplex/git/cocotb/build/libs/i686:${LD_LIBRARY_PATH}
# export SIM=modelsim
# ARCH=i686 make
# export COCOTB=/home/simplex/git/cocotb


# Add  to MANPATH.
# Add /usr/local/texlive/2017/texmf-dist/doc/info to INFOPATH.
# Most importantly, add /usr/local/texlive/2017/bin/x86_64-linux

export MANPATH=${MANPATH}:/usr/local/texlive/2017/texmf-dist/doc/man
export INFOPATH=${INFOPATH}:/usr/local/texlive/2017/texmf-dist/doc/info
export PATH=${PATH}:/usr/local/texlive/2017/bin/x86_64-linux
