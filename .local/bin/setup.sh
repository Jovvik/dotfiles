#!/usr/bin/env sh

echo "Do you wish to install packages?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) if ! command -v yay &> /dev/null
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
              break;;
        No ) break;;
    esac
done

echo "Do you wish to install vscode extensions?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) xargs -L 1 code --install-extension < ~/.config/Code\ -\ OSS/User/extensionlist
              break;;
        No ) break;;
    esac
done
