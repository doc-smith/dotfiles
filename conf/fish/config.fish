if status is-interactive
    set -gx PATH $PATH ~/bin
end

if test /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end 

fish_config theme choose termcolors