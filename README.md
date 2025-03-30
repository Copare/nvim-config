# nvim-config



If you already have neovim, make backups of your configuration.
Remove the current nvim configuration and cache if it exists:

    rm -rf ~/.config/nvim ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim

Execute the commands to install:

    sudo apt install git npm  # Debian
    
    mkdir -p ~/.config/nvim
    git clone https://github.com/Copare/nvim-config.git ~/.config/nvim
