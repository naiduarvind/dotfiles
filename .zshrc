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


##########################################################################################################################################################################
# CUSTOM ALIASES
##########################################################################################################################################################################
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# full list of active aliases, run `alias`.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# aliases to change one directory back and to home.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alias ~="cd ~"
alias ..="cd .."

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# alias to initiate lock screen when away from keyboard.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# alias to switch AWS profile seamlessly.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alias awsp="source _awsp"

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# aliases to crank up volume to full or crank down to mute.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alias pumpitup="osascript -e 'set volume output volume 100'"
alias stfu="osascript -e 'set volume output muted true'"

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# alias to display current week in calendar.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alias week='date +%V'

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# alias to perform update for all commonly used softwares / package managers.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alias update='sudo softwareupdate -i -a --restart; brew update; brew upgrade; brew cleanup'

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# aliases to view logs of dns services in Kubernetes (kubedns).
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alias klkubedns='kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c kubedns'
alias kldnsmasq='kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c dnsmasq'
alias klsidecar='kubectl logs --namespace=kube-system $(kubectl get pods --namespace=kube-system -l k8s-app=kube-dns -o name | head -1) -c sidecar'

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# alias to view logs of dns service in Kubernetes (coredns).
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
alias klcoredns='for p in $(kubectl get pods --namespace=kube-system -l k8s-app=coredns -o name); do kubectl logs --namespace=kube-system $p; done'

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

###########################################################################################################################################################################
# CUSTOM FUNCTIONS
###########################################################################################################################################################################

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to backup all resources of a Kubernetes cluster.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function bka() {
	ark backup create $@
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to backup all resources specific to a namespace of a Kubernetes cluster.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function bkns() {
	ark backup create ${1} --include-namespaces=${2}
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to show the names (CNs and SANs) listed in SSL certificate for a given domain.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified.";
		return 1;
	fi;

	local domain="${1}";
	echo "Testing ${domain}…";
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version");
		echo "Common Name:";
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
		echo ""; # newline
		echo "Subject Alternative Name(s):";
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
		return 0;
	else
		echo "ERROR: Certificate not found.";
		return 1;
	fi;
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to list helm releases.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function hl() { 
	helm list $@; 
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to delete helm releases.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function hd() { 
	helm del --purge $@; 
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to create a new directory and enter it.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function mkd() {
	mkdir -p "$@" && cd "$_";
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to check the metrics API in Kubernetes.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function kgms() {
	if [ $@ = "external" ]; then
		kubectl get --raw "/apis/external.metrics.k8s.io/v1beta1" | jq
	elif [ $@ = "custom" ]; then
		kubectl get --raw "/apis/custom.metrics.k8s.io/v1beta1" | jq
	else
		kubectl get --raw "/apis/metrics.k8s.io/" | jq
	fi
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function targz() {
	local tmpFile="${@%/}.tar";
	tar -cvf "${tmpFile}" --exclude=".DS_Store" "${@}" || return 1;

	size=$(
		stat -f"%z" "${tmpFile}" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}" 2> /dev/null;  # GNU `stat`
	);

	local cmd="";
	if (( size < 52428800 )) && hash zopfli 2> /dev/null; then
		# the .tar file is smaller than 50 MB and Zopfli is available; use it
		cmd="zopfli";
	else
		if hash pigz 2> /dev/null; then
			cmd="pigz";
		else
			cmd="gzip";
		fi;
	fi;

	echo "Compressing .tar ($((size / 1000)) kB) using \`${cmd}\`…";
	"${cmd}" -v "${tmpFile}" || return 1;
	[ -f "${tmpFile}" ] && rm "${tmpFile}";

	zippedSize=$(
		stat -f"%z" "${tmpFile}.gz" 2> /dev/null; # macOS `stat`
		stat -c"%s" "${tmpFile}.gz" 2> /dev/null; # GNU `stat`
	);

	echo "${tmpFile}.gz ($((zippedSize / 1000)) kB) created successfully.";
}

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function to upload a file to transfer.sh that presents a direct download link.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function transfer() { 
  if [ $# -eq 0 ]; 
    then echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; 
    return 1; 
  fi 
  tmpfile=$( mktemp -t transferXXX ); 
  if tty -s; 
    then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); 
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; 
  else 
    curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; 
  fi; 
  cat $tmpfile; rm -f $tmpfile; 
} 

#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# function for `tree` with hidden files and color enabled, ignoring the `.git` directory, listing directories first.
# output gets piped into `less` with options to preserve color and line numbers, unless the output is small enough for one screen.
#-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}