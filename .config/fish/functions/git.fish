# Defined in - @ line 1
function git --wraps='proxychains git' --description 'alias git proxychains git'
  proxychains git $argv;
end
