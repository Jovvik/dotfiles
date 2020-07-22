# My dotfiles for manjaro (i3 edition)

![](Pictures/screenshots/flex.png)
![](Pictures/screenshots/flex2.png)

## Main packages used

- Terminal emulator: [kitty](https://github.com/kovidgoyal/kitty)
- Editor: [vscode _(open source build with transparency)_](https://github.com/microsoft/vscode), `code-transparent` in AUR
- Window manager: [i3-gaps](https://github.com/Airblader/i3)
- Compositor: [picom _(with rounded corners and fancy blur)_](https://github.com/ibhagwan/picom)
- Status bar: [polybar](https://github.com/polybar/polybar)
- Shell: [fish](https://github.com/fish-shell/fish-shell)
  - Release: bleeding edge (`fish-git` in AUR)
  - Package/theme manager: [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish)
  - Theme: [spacefish](https://github.com/matchai/spacefish)
- Font: [Jetbrains Mono _(with nerd fonts patch)_](https://github.com/JetBrains/JetBrainsMono), `nerd-fonts-jetbrains-mono` in AUR
- Color theme: generated by [pywal](https://github.com/dylanaraps/pywal) from my [wallpaper](Pictures/wallpapers/wall.png)

## TODO

### Bugfixes

- [x] Clean up i3 config
- [x] Fix links in kitty
- [x] Fix large images breaking ranger
- [ ] Rename compton configs to picom
- [ ] Fix icon size in rofi
- [x] Fix fish forgetting pywal's colors sometimes
- [ ] Fix compton's shadow not covering bottom right corner
- [ ] Switch to a consistent set of fontawesome icons in polybar (either solid or regular)

### Additions

- Play around with:
  - [x] ranger
  - [ ] ranger preview script _(pdf support)_
  - [x] kitty
- [x] Add a list of vscode extensions
- [x] Create bootstrapping scripts for necessary packages and vscode extensions
- [ ] Add rofi scrots
