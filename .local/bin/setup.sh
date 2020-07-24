#!/usr/bin/env sh

echo "Do you wish to install packages?"
while true; do
    read -r yn
    case $yn in
        [Yy]* ) if ! type yay >/dev/null 2>&1
                then
                    echo "Couldn't find `yay`"
                    if ! type pacman >/dev/null 2>&1
                    then
                        echo "Couldn't find `pacman` either, not arch-based distros aren't supported"
                        echo "You can install packages yourself with `<package manager> $(grep '^[a-Z]' ~/.config/pkglist)`"
                        exit 1
                    fi
                    echo "Trying to install `yay`"
                    sudo pacman -S yay || echo "`yay` installation failed, aborting..." && exit 1
                fi
                yay -S $(grep '^[a-Z]' ~/.config/pkglist | tr "\n" " ")
                break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "Do you wish to install vscode extensions?"
while true; do
    read -r yn
    case $yn in
        [Yy]* ) xargs -L 1 code --install-extension < ~/.config/Code\ -\ OSS/User/extensionlist
              break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
