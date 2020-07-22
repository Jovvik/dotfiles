#!/usr/bin/env sh

if ! command -v yay &> /dev/null
then
    echo "Couldn't find `yay`"
    if ! command -v pacman &> /dev/null
    then
        echo "Couldn't find `pacman` either, not arch-based distros aren't supported"
        echo "You can install packages yourself with `<package manager> $(grep '^[a-Z]' ~/.config/pkglist)`"
        exit 1
    fi
    echo "Trying to install `yay`"
    sudo pacman -S yay || echo "`yay` installation failed, aborting..." && exit 1
fi
yay -S $(grep '^[a-Z]' ~/.config/pkglist)
