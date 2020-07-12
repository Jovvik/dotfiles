# Defined in - @ line 1
function ls --wraps='exa --icons' --description 'alias ls=exa --icons'
  exa --icons $argv;
end
