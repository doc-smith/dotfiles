if status is-interactive
    set -gx PATH $PATH ~/bin
end

if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end 

fish_config theme choose termcolors