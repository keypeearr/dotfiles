if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Path Variables
fish_add_path $HOME/go/bin
fish_add_path $HOME/.local/share/nvim/mason/bin

# Remove fish greeting
set fish_greeting ""

# Start Neofetch
fastfetch

# Start Oh My Posh
oh-my-posh init fish --config "~/.config/oh-my-posh/config.json" | source
