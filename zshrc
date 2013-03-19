# prompt

function prompt_git_dirty() {
    gitstat=$(git status 2>/dev/null | grep '\(# Untracked\|# Changes\|# Changed but not updated:\)')
    
    if [[ $(echo ${gitstat} | grep -c "^# Changes to be committed:$") > 0 ]]; then
        echo -n $PR_LIGHT_YELLOW
    elif [[ $(echo ${gitstat} | grep -c "^\(# Untracked files:\|# Changed but not updated:\)$") > 0 ]]; then
        echo -n $PR_LIGHT_RED
    else
        echo -n $PR_LIGHT_MAGENTA
    fi
}

function prompt_current_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return 1
    echo ${ref#refs/heads/}
}

function prompt_hostname()
{
    case "`hostname`" in
        "Arch")
            echo -n "${PR_LIGHT_YELLOW}Arch${PR_BLUE}";;    
    esac
}

                                   
#
#based on Barrucadu (prompt):https://bbs.archlinux.org/viewtopic.php?pid=831695#p831695
# 
#------------------------------
# History stuff
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

#------------------------------
# Variables
#------------------------------
export BROWSER="chromium"
export EDITOR="vim"
export PAGER="vimpager"
export PATH="${PATH}:${HOME}/bin:${HOME}/.cabal/bin"

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
bindkey -v
typeset -g -A key
#bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
#bindkey '\e[2~' overwrite-mode
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for gnome-terminal
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

#------------------------------
# Alias stuff
#------------------------------
alias ls="ls --color -F"
alias ll="ls --color -lh"
alias spm="sudo pacman"
alias spmc="sudo pacman-color"
alias gr="gvim --remote-silent"
 alias update='sudo pacman -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
 alias instalar='sudo pacman -S'           # Install specific package(s) from the repositories
 alias pacins='sudo pacman -U'          # Install specific package not from the repositories but from a file 
 alias remover='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
 alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
 alias pacrep='pacman -Si'              # Display information about a given package in the repositories
 alias procurar='pacman -Ss'             # Search for package(s) in the repositories
 alias pacloc='pacman -Qi'              # Display information about a given package in the local database
 alias paclocs='pacman -Qs'             # Search for package(s) in the local database
alias pacman='pacman-color'
#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist
autoload -Uz compinit
compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always


#/home/archierp/.invaders.sh

PS1=$'%{\e[1;30m%}[%{\e[0m%} %{\e[1;35m%}%~%{\e[0m%}%{\e[1;30m%}]%{\e[0m%}%{\e[0;34m%}$%{\e[0m%} '

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
