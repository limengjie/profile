#========================================================================== 
# Terminal Settings 
#========================================================================== 
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth
HISTSIZE=1000
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTIGNORE="&:[ ]*:@(?|??|???|????)"
# [ \t]* ignores commands begin with !
shopt -s cmdhist
# append to the history file, don't overwrite it
shopt -s histappend

# default mode
umask 002

# Select several lines from a file. 
# e.g., sel /etc/passwd 2 4 6
function sel() {
  local target="$1"
  local cmdexpr="-n"
  local lastline=0
  shift
  for i in "$@"; do
    cmdexpr="$cmdexpr -e '${i}p'"
    if [ "$i" -gt "$lastline" ]; then
      lastline="$i"
    fi
  done
  local cmdexpr="$cmdexpr -e '${lastline}q'"
  eval "cat -n $target | sed $cmdexpr"
}

# alias
alias grep="grep $COLOR"
alias nau='nautilus'
alias l="\ls -hl $COLOR"      # show detailed info
alias la="\ls -Al $COLOR"       # show hidden files
alias lt="\ls -ltc $COLOR"     # sort by change time
alias lx="\ls -lXB $COLOR"      # sort by extension
alias lr="\ls -lR $COLOR"       # recursive ls
alias ls="\ls -lhS $COLOR"      # sort by size

#today
alias today="date +'%A, %B %-d, %Y'"

# tmux preferred if exist
if type tmux >/dev/null 2>&1; then
  alias s='tmux'
  alias r='tmux attach -d'
else
  # http://askubuntu.com/questions/9920/x11-forwarding-over-gnu-screen-is-it-possible
  alias screen='env DISPLAY=$DISPLAY screen'
  alias s='screen'
  alias r='screen -D -R'
fi

#if type python26 >/dev/null 2>&1; then
  #alias python='python26'
#fi
if libtool --version >/dev/null 2>&1; then
  alias gdb='libtool --mode=execute gdb'
fi
alias ymd='date +%y%m%d'
alias smth='luit -encoding gbk telnet bbs.newsmth.net'

# options
#set -u  # do not expand undefined variable to null, report error instead
shopt -s cdable_vars
shopt -s extglob

# hadoop
export HADOOP_CONF_DIR=/home/chm/hadoop/conf
export HADOOP_HOME=/home/chm/hadoop

alias ghadoop='luit -encoding gbk ssh -o GSSAPIAuthentication=no ime@10.12.11.200'
alias gdev='luit -encoding gbk ssh -o GSSAPIAuthentication=no chenming@10.11.203.218'
alias gdd='luit -encoding gbk ssh -o GSSAPIAuthentication=no root@10.10.65.76'

# settings
export EDITOR=vim
export SVN_EDITOR=vim

# fix iBus issues on start
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash
export CVSROOT=mchen@cvs.fsl.cs.sunysb.edu:/scm/cvsroot/

alias chev='ssh -tt mchen@msl.cewit.stonybrook.edu ssh -tt mchen@chevron8'

export AWKPATH=$AWKPATH:~/profile/awk

export PATH=/usr/local/bin:$PATH

alias f1='fg 1'
alias f2='fg 2'
alias f3='fg 3'

complete -o default -o nospace -F _man vman

if [ -f ~/profile/functions.shrc ]; then
  source ~/profile/functions.shrc
  source_files
fi

#========================================================================== 
# Other useful aliases
#========================================================================== 
alias ls="ls --color=auto"
alias ll="ls -al"
alias l='less'
alias grep="grep --color"
alias rm='rm -rf'
alias cp='cp -r'
alias xterm="xterm -bg black -fg white"
alias print="lp -o sides=two-sided-long-edge"
alias vi="vim"

# Makes cd automatically do ls
#function cd() {
  #builtin cd "$*" ; ls
#}

export PS1='\[\e[0;36m\][\T \d]\[\e[1;30m\]\[\e[1;33m\]\u@\H\[\e[1;30m\]:\[\e[1;38m\]\w\[\e[0;38m\]$ '
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/mli55/mcsim/pin-2.11/intel64/runtime:/home/mli55/mcsim/pin-2.11/intel64/lib-ext:/usr/local/lib
#:/home/mogleari/research/snappy/lib:/usr/local/lib
export PIN=/home/mli55/mcsim/pin-2.11/intel64/bin/pinbin
export PINTOOL=/home/mli55/mcsim/pin-2.11/source/tools/Pthread/mypthreadtool

alias print="lp -o sides=two-sided-long-edge"


alias print="lp -o "


alias print="lp -o sides=one-sided-long-edge"

