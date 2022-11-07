if status is-interactive
    set -gx PATH $PATH ~/bin
end

eval (/opt/homebrew/bin/brew shellenv)

fish_config theme choose termcolors