source "$HOME/.config/zsh/config.zsh"

return;

# !!! The below configuration is deprecated. Do not use.


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/maru85945/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# starts zsh-vi-mode initialisation immediately
# ZVM_INIT_MODE='sourcing'

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  gitfast
  nvm 
  history-substring-search
  zsh-autosuggestions
  zsh-vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration
source $HOME/.config/zsh/.gitaliases
source $HOME/.config/zsh/.functions

# Yarn scripts auto-completion
if [ -f $HOME/.config/zsh/.yarn-completion.bash ]; then
    source $HOME/.config/zsh/.yarn-completion.bash;
    __yarn_completion_complete y;
fi

# Load nvm
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PATH="$PATH":"$HOME/bin"
export PATH="$PATH":"/usr/local/opt/mysql-client/bin"
export EDITOR=nvim

function doesFileExists() {
  local file=$1;
  local root_dir=$(git rev-parse --show-toplevel 2> /dev/null || pwd);

  if [[ -f "$root_dir/$file" || -f "$file" ]]; then
    echo true;
  else
    echo false;
  fi
}

# # Yarn shortener (with args only)
function y() {
  local bin=${1:=''};
  local pnpm_lock=$(doesFileExists 'pnpm-lock.yaml');
  local yarn_lock=$(doesFileExists 'yarn.lock');
  local package_lock=$(doesFileExists 'package-lock.json');

  if [[ "$pnpm_lock" = true ]]; then
    bin=pnpm
  elif [[ "$yarn_lock" = true ]]; then
    bin=yarn
  elif [[ "$package_lock" = true ]]; then
    bin=npm
  else
    echo 'No known lockfile found, unable to guess package manager.'
    echo 'You may run the install manually: e.g. $ npm install'
    exit -1
    return;
  fi

  if [ $# -eq 0 ]; then
    $bin install
  else
    $bin $@ || $bin run $0;
  fi
}

function img() {
  case $1 in
    'clone')
      local repo_name=$(gh repo list IMGARENA | cut -f1 | fzf -f ${2:-''} | fzf);

      git clone "https://github.com/$repo_name";
      cd ${repo_name#*/};
      ;;
  esac
}

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

_on_directory_change() {
  # emulate -L zsh
  # try to always use the right node version in a terminal
  if [ -f ./.nvmrc ]; then
    nvm use 2>&1 > /dev/null
  fi
}
chpwd_functions=("_on_directory_change")


# Create or attach tmux session
work() {
  tmux new-session -A -s $1
}

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

# might not be needed anymore
# PREFIX='/usr/local/opt/browserpass' make hosts-chrome-user -f '/usr/local/opt/browserpass/lib/browserpass/Makefile'

export BTEC_DEV_PRIMARY_AUTH=imgarena:HPFotirXMaeIzkYEE5cEGy7d
export PNPM_HOME="/Users/maru85945/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

bindkey -v
# zsh-autosuggestions
bindkey '^ ' autosuggest-execute
bindkey -M viins '^@' autosuggest-execute
bindkey -M viins '^L' autosuggest-accept

_user_key_binding() {
  bindkey '^K' clear-screen
  bindkey "^[[A" history-substring-search-down
  bindkey "^[[B" history-substring-search-up
}
precmd_functions+=(_user_key_binding)

# LF
LFCD="$HOME/.config/lf/lfrc"                                #  pre-built binary, make sure to use absolute path

if [ -f "$LFCD" ]; then
    source "$LFCD"
fi

# Created by `pipx` on 2023-05-24 09:22:55
export PATH="$PATH:/Users/maru85945/.local/bin"

# pnpm
export PNPM_HOME="/Users/maru85945/maru85945/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[[ -f /Users/maru85945/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh ]] && . /Users/maru85945/.npm/_npx/6913fdfd1ea7a741/node_modules/tabtab/.completions/electron-forge.zsh