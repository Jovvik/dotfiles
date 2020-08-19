# Defined in - @ line 1
function ll --wraps='exa -l --icons' --description 'alias ll exa -l --icons'
  exa -l --icons $argv; 
end
