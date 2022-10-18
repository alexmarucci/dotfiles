# Enable colors and change prompt:
autoload -U colors && colors
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# Neovide multigrid
export NEOVIDE_FRAME='buttoless'
export NEOVIDE_MULTIGRID=true

source ~/.config/zsh/plugins/git.zh
source ~/.config/zsh/themes/bira.zsh

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload bashcompinit
bashcompinit
autoload -U compinit
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

# Auto suggestions binding
bindkey '^K' clear-screen

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

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Use lf to switch directories and bind it to ctrl-o
bindkey -s '^n' 'nvim\n'

# Provide smartlog fn
alias sl=$HOME/projects/hacks/smartlog/smartlog.mjs

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

# User configuration
source $HOME/.config/zsh/.gitaliases
source $HOME/.config/zsh/.functions

# Yarn scripts auto-completion
if [ -f $HOME/.config/zsh/.yarn-completion.bash ]; then
    source $HOME/.config/zsh/.yarn-completion.bash;
    __yarn_completion_complete y;
fi

# Load better nvm
alias nvm=fnm
eval "$(fnm env --shell zsh --use-on-cd)"

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export EDITOR=nvim

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
export BTEC_DEV_PRIMARY_AUTH=imgarena:HPFotirXMaeIzkYEE5cEGy7d
export PNPM_HOME="$HOME/maru85945/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Plugins
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
