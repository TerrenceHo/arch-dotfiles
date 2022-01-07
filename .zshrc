alias vi="nvim"
alias vim="nvim"
alias g="git"

alias sz="source ~/.zshrc"
alias vz="vim ~/.zshrc"

# Safety
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# Listing Aliases
alias ls="ls --color=auto"
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'
alias ds="dirs -v | head -10"

# Directories
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'
alias md='mkdir -p'
alias rd=rmdir
alias d='dirs -v | head -10'
alias pu='pushd'
alias po='popd'


#Grep
alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '
alias t='tail -f'

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --type f --exclude '.git'/ --strip-cwd-prefix"
export FZF_DEFAULT_OPTS="-m --layout=reverse --border --height=40% --info=inline"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_COMMAND="$FZF_DEFAULT_COMMAND"

# Sorts numeric filenames numerically instead of lexicographically
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"

#----------------------------Globbing--------------------
# Makes globs case-insensitive
unsetopt case_glob

# Makes globbing regexes case-insensitive
unsetopt case_match

# Allows globs to match dotfiles
setopt glob_dots

# Sorts numeric filenames numerically instead of lexicographically
setopt numeric_glob_sort

#----------------------------History----------------------
# History file location
export HISTFILE=~/.zsh_history

# Removes the specified commands from the history
export HISTIGNORE="ls:[bf]g:exit:reset:clear:htop"

# Number of lines saved in a session
export HISTSIZE=25000

# Number of lines saved in the history file
export SAVEHIST=10000

# Uses OS-provided locking mechanisms for the history file if available to possibly improve performance and decrease the chance of corruption
setopt hist_fcntl_lock

# Prevents the current line from being saved in the history if it is the same as the previous one
setopt hist_ignore_dups

# Removes superfluous blanks from the history
setopt hist_reduce_blanks

# Expands command instead of immediately executing it when using history expansion
setopt hist_verify

# Incrementally append new history lines to history file rather than waiting until the shell exits
setopt inc_append_history

# Disables sharing history between different zsh sessions
unsetopt share_history

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

#------------------------QOL Improvements-----------------
# Uses commas in ls, du, df file size output
export BLOCK_SIZE="'1"

# Colored output on macOS
export CLICOLOR=1

# Prints command execution time if command takes longer than 10 seconds
export REPORTTIME=10

# Background processes aren't killed on exit of shell
setopt auto_continue

# Enter directory path to automatically cd into the directory
setopt autocd

# Makes cd push the old directory onto the directory stack
setopt autopushd

# Doesn't push duplicates onto directory stack
setopt pushd_ignore_dups

# Attempts to correct spelling of all arguments in a line
setopt correct_all

# Allows comments in the interactive shell
setopt interactive_comments

# Doesn’t overwrite existing files with '>' but uses '>!' instead
setopt noclobber

# Swaps the meaning of '-' and '+' when used as arguments to cd so '-' means reading from the top of the stack when accessing an entry from the directory stack
setopt pushdminus

# Prompts for confirmation after 'rm *'-ish commands to avoid accidentally wiping out directories
setopt rm_star_wait

#----------------------------Tabbing----------------------
autoload -U compinit -u && compinit -u
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

#----------------------------SSH-Agent--------------------
eval $(keychain --eval --quiet id_ed25519)

#----------------------------PROMPT-----------------------
setopt promptsubst
autoload -U colors && colors

GIT_THEME_PROMPT_DIRTY='✗'
GIT_THEME_PROMPT_UNPUSHED='+'
GIT_THEME_PROMPT_CLEAN='✓'

function parse_git_dirty() {
   if [[ -n $(git status -s 2> /dev/null |grep -v ^\# | grep -v "working directory clean" ) ]]; then
       echo -ne "%F{160}${GIT_THEME_PROMPT_DIRTY}"
   else
       echo -ne "%F{64}${GIT_THEME_PROMPT_CLEAN}"
   fi
   GIT_CURRENT_BRANCH=$(git name-rev --name-only HEAD 2> /dev/null)
   GIT_ORIGIN_UNPUSHED=$(git log origin/$GIT_CURRENT_BRANCH..$GIT_CURRENT_BRANCH --oneline 2>&1 | awk '{ print $1 }')
   if [[ $GIT_ORIGIN_UNPUSHED != "" ]]; then
       echo -e "%F{136}${GIT_THEME_PROMPT_UNPUSHED}"
   fi
}

function parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1) $(parse_git_dirty) /"
}

function shorten_path_prompt() {
  echo $(pwd | perl -pe "
   BEGIN {
      binmode STDIN,  ':encoding(UTF-8)';
      binmode STDOUT, ':encoding(UTF-8)';
   }; s|^$HOME|~|g; s|/([^/])[^/]*(?=/)|/\$1|g
")
}

local ret_status="%(?:%{$fg_bold[green]%}➜:%{$fg_bold[red]%}➜)"
PROMPT='${ret_status} %B%F{125}%n%F{245}@%F{166}%m %F{33}$(shorten_path_prompt) %F{61}$(parse_git_branch)%F{245}$ %f%b'
