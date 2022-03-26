alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

set fish_greeting

# cat ~/.cache/wal/sequences &

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/jovvik/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
