##########################################################################################################################################################################
# CORE ZSH SETTINGS
##########################################################################################################################################################################

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# oh-my-zsh installation directory.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
export ZSH=$HOME/.oh-my-zsh

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# powerline theme to load on startup.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ZSH_THEME="powerlevel9k/powerlevel9k"

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# powerline font to load on startup.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
POWERLEVEL9K_MODE="nerdfont-complete"

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# setting locale for terminal.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# setting PATH for terminal.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
export PATH=$HOME/Projects/personal/go/bin:$PATH

##########################################################################################################################################################################
# ZSH PLUGINS
##########################################################################################################################################################################

plugins=(
  autojump
  aws
  colored-man-pages
  common-aliases
  git
  kubectl
  kube-aliases
  rsync
  sudo
  vault
  vscode
  zsh_reload
  zsh-autosuggestions
  zsh-completions
)

##########################################################################################################################################################################
# ZSH SOURCES
##########################################################################################################################################################################

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# load oh-my-zsh plugins into zsh shell.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
source $ZSH/oh-my-zsh.sh

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# load custom aliases into zsh shell.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
source ~/.zsh_aliases

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# load custom functions into zsh shell.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
source ~/.zsh_functions

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# load kubernetes autocomplete into zsh shell.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
source <(kubectl completion zsh)

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# load stern autocomplete into zsh shell.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
source <(stern --completion=zsh)

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# load syntax highlighting into zsh shell.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###########################################################################################################################################################################
# CUSTOM EXPORTS
###########################################################################################################################################################################

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# export for preferred in terminal editor.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='vim'
fi

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# export for setting Go path.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
export GOPATH=$HOME/Projects/personal/go

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
export GPG_TTY=$(tty);

###########################################################################################################################################################################
# CUSTOM POWERLINE VISUALIZATIONS
###########################################################################################################################################################################

prompt_zsh_showStatus () {
	local color='%F{white}'
  state=`osascript -e 'tell application "Spotify" to player state as string'`;
  if [ $state = "playing" ]; then
    artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`;
    track=`osascript -e 'tell application "Spotify" to name of current track as string'`;

      echo -n "%{$color%} $artist - $track " ; 

  fi
}

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status user aws kubecontext time ram os_icon battery)

POWERLEVEL9K_BATTERY_ICON='\uf1e6'
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_LOW_THRESHOLD='10'
POWERLEVEL9K_BATTERY_LOW_COLOR='red'

POWERLEVEL9K_KUBECONTEXT_BACKGROUND="red3"
POWERLEVEL9K_KUBECONTEXT_FOREGROUND="white"

POWERLEVEL9K_OS_ICON_BACKGROUND="grey"
POWERLEVEL9K_OS_ICON_FOREGROUND="white"

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"

POWERLEVEL9K_STATUS_OK_BACKGROUND='green3'
POWERLEVEL9K_STATUS_OK_FOREGROUND='black'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='darkorange'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='white'

POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

POWERLEVEL9K_AWS_BACKGROUND="blue"

POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"
# Visual customisation of the second prompt line
local user_symbol="$ "
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

##########################################################################################################################################################################
# GENERAL ITERM2 SETTINGS
##########################################################################################################################################################################

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# colorise the tabs of iTerm2 with the background color.
# just change 18/26/33 which are RGB values.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
echo -e "\033]6;1;bg;red;brightness;18\a"
echo -e "\033]6;1;bg;green;brightness;26\a"
echo -e "\033]6;1;bg;blue;brightness;33\a"

##########################################################################################################################################################################
# GENERAL ZSH SETTINGS
##########################################################################################################################################################################

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
# setopt share_history # share history between different instances of the shell

setopt correct_all # autocorrect commands

setopt auto_list # automatically list choices on ambiguous completion
setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match

zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# Enable autocompletions
autoload -Uz compinit
typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ $(date +'%j') != $updated_at ]; then
  compinit -i
else
  compinit -C -i
fi
zmodload -i zsh/complist

autoload -Uz history-beginning-search-menu
zle -N history-beginning-search-menu
bindkey '^X^X' history-beginning-search-menu