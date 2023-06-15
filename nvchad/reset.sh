rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim

git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth

ln -s ~/.902LabsDotsFiles/nvchad/custom ~/.config/nvim/lua/custom
