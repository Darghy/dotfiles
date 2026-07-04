# Homebrew environment (PATH etc.)
/opt/homebrew/bin/brew shellenv | source

if status is-interactive
    # Disable the default greeting
    set -g fish_greeting
end
