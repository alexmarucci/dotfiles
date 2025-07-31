export NODE_TLS_REJECT_UNAUTHORIZED=0
# Enable colors and change prompt:
autoload -U colors && colors
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don\'t record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don\'t record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don\'t write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# Variables 
# Neovide multigrid
export NEOVIDE_FRAME='buttoless'
export NEOVIDE_MULTIGRID=true
export EDITOR=nvim
export GIT_EDITOR="nvim"
export NVIM_APPNAME=kickstart-nvim

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Load custom auto comp
fpath=($HOME/.config/zsh/custom-completion $fpath)

# Basic auto/tab complete:
autoload bashcompinit
bashcompinit
autoload -U +X compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Enable hooks
autoload -U add-zsh-hook

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Add binding to insert-last-word
bindkey '\e.' insert-last-word
bindkey -M viins '\e.' insert-last-word

# Auto suggestions binding
bindkey '^K' clear-screen

# Use lf to switch directories and bind it to ctrl-o
bindkey -s '^o' 'lfcd\n'
bindkey -s '^n' 'nvim\n'

# Open zsh config with ctrl-z
bindkey -s '^z' 'cd ~/.config/zsh && nvim\n'

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Alias for neovide
# alias neo="open -n $HOME/Applications/Neovide.app/ --args --multigrid --frame buttonless"
# alias neo="open -n -a Neovide --args '--multigrid' '--frame=buttonless' '--' '--cmd' ' ' '\"cd $(pwd)\"'"
function neo() {
  local PROJECT_DIR="${1:=$PWD}";

  if [[ "$PROJECT_DIR" != /* ]]; then
     # Relative path
     PROJECT_DIR="$(pwd)/${PROJECT_DIR}"
  fi

  if [[ -e "${PROJECT_DIR}" ]]; then
    open -n -a Neovide --args '--multigrid' '--frame=buttonless' '--' '--cmd' ' ' "\"cd ${PROJECT_DIR}\""
  else
    echo "${PROJECT_DIR} does not exists."
  fi
}
# Open drex as file explorer
alias dr='nvim -c "Drex"'
function nav() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# User configuration
source $HOME/.config/zsh/.gitaliases
source $HOME/.config/zsh/.dockeraliases
source $HOME/.config/zsh/.functions

# Yarn scripts auto-completion
# Requires "pnpm install -g yarn-completion"
if [ -f $HOME/.config/zsh/.yarn-completion.bash ]; then
    source $HOME/.config/zsh/.yarn-completion.bash;
    __yarn_completion_complete y;
fi

function nx() {
    npx nx "$@"
}
source ~/.config/zsh/plugins/zsh-nx-completion/nx-completion.plugin.zsh;

# Load better nvm
alias nvm=fnm
eval "$(fnm env --shell zsh --use-on-cd)"

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Set tab title to current dir
DISABLE_AUTO_TITLE="true"

tab_title() {
  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

add-zsh-hook precmd tab_title

precmd() {
  # sets the tab title to current dir
  tab_title "\e]1;${PWD##*/}\a"
}

# Work stuff
# pnpm
export PNPM_HOME="/Users/alessio/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# yarn or static
local yarn_dir="$(yarn global dir > /dev/null 2>&1)";
local static_yarn_dir="$HOME/.config/yarn/global/";
local yarn_global_bin="${yarn_dir:-$static_yarn_dir}/node_modules/.bin/";
PATH="$yarn_global_bin:$PATH"
PATH="/Users/alessio/.local/bin:$PATH"
RUSTUP_PATH=$(brew --prefix rustup)/bin
PATH="$RUSTUP_PATH:$PATH"

# pyenv python version
PATH=$(pyenv root)/shims:$PATH

# pnpm end
# local YARN_GLOBAL_DIR="$(yarn global dir)/node_modules/.bin/";
# export PATH="$YARN_GLOBAL_DIR:$PATH"


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Plugins
source ~/.config/zsh/plugins/git.zh
source ~/.config/zsh/themes/bira.zsh
source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey -M viins '^L' autosuggest-accept

source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Load zsh-syntax-highlighting; should be last.
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Load after highlight enabled
source "$HOME/.config/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
bindkey "^[[B" history-substring-search-down # Arrow up
bindkey "^[[A" history-substring-search-up # Arrow down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Initialise zoxide
eval "$(zoxide init zsh)"
alias cd="z"
alias d="z"

# Docker Login 
local is_logged_in=$(grep 'registry.gitlab.com' ~/.docker/config.json)

if [ -z "$is_logged_in" ]; then
  gitlab_username=alessio.marucci1
  echo $GITLAB_NPM_TOKEN | docker login registry.gitlab.com -u $gitlab_username --password-stdin >> /dev/null
fi
