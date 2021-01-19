# Defined in - @ line 1
function yay --wraps='proxychains yay' --description 'alias yay proxychains yay'
  proxychains yay $argv;
end
