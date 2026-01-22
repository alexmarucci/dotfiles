#!/usr/bin/env sh

# Bootstrap script to symlink dotfiles to ~/.config

echo "######################"
echo "#                    #"
echo "#     !Welcome!      #"
echo "#                    #"
echo "######################"

read -p "Should we start the bootstrap? (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Let's go!"
else
    echo "Goodbye!"
    exit 1
fi

echo "Symlinking dotfiles..."
for folder in dotfiles/*; do
    target="$HOME/.config/$(basename "$folder")"

    # want to override target
    if [[ -e "$target" ]]; then
        read -p "$target already exists, override? (y/N) " -n 1 -r
        echo

        if [[ $REPLY =~ ^[Yy]$ ]]; then
            rm -rf "$target"
        else
            continue
        fi
    fi

    ln -sf "$(pwd)/$folder" "$target"
    echo "Linked: $folder -> $target"
done

if ! command -v brew &> /dev/null
then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

read -p "Should we install brew packages? (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Installing packages..."
    brew bundle --file=$HOME/.config/Brewfile
fi

# does zsh exists
if command -v zsh &> /dev/null
then
    echo "Setting zsh as default shell..."
    chsh -s $(which zsh)
else
    echo "Zsh was not installed."
    exit 1
fi

read -p "Should we link your claude-code config ? (y/N) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "Symlinking .claude/... files"
    for folder in claude/*; do
        target="$HOME/.claude/$(basename "$folder")"

        # want to override target
        if [[ -e "$target" ]]; then
            read -p "$target already exists, override? (y/N) " -n 1 -r
            echo

            if [[ $REPLY =~ ^[Yy]$ ]]; then
                rm -rf "$target"
            else
                continue
            fi
        fi

        ln -sf "$(pwd)/$folder" "$target"
        echo "Linked: $folder -> $target"
    done
fi
