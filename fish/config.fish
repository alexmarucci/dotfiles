if status is-interactive
    # Commands to run in interactive sessions can go here
    source $HOME/.config/zsh/.gitaliases

    # vi-mode
    fish_hybrid_key_bindings # keeps emacs binding in insert mode

    # mappings
    bind \ck 'tput reset; clear; commandline -f repaint'
    bind \cl accept-autosuggestion
    # bind in vi-mode
    bind -M insert \ck 'tput reset; clear; commandline -f repaint'
    bind -M insert \cl accept-autosuggestion

    # Auto complete y command

    # Load nvm
    alias nvm=fnm

    export PATH="$PATH":"$HOME/bin"
    export PATH="$PATH":"/usr/local/opt/mysql-client/bin"
    export EDITOR=nvim
    export BTEC_DEV_PRIMARY_AUTH=imgarena:HPFotirXMaeIzkYEE5cEGy7d
    export PNPM_HOME="/Users/maru85945/Library/pnpm"
    export PATH="$PNPM_HOME:$PATH"
end
