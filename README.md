# Dotfiles Repository

This repository contains configuration files for various development tools and environments. It serves as a centralized location for managing dotfiles across different systems. The setup focuses on manual symbolic links to maintain control over what gets installed and where.

## Project Overview

These dotfiles include configurations for:
- Terminal emulators (Alacritty, Ghostty)
- Shell environments (Zsh, Bash)
- Text editors (Neovim with LazyVim and NvChad variants)
- Version control (Git)
- Terminal multiplexer (Tmux)
- Search tools (Ripgrep)
- Package management (Homebrew)
- Fonts (CommitMono Nerd Font)
- AI agent system (OpenCode)

All configurations are stored in `~/.dotfiles` and linked manually to their expected locations. This approach allows for easy updates, backups, and selective installation.

## Manual Symlink Instructions

Clone this repository to `~/.dotfiles` first:

```bash
git clone <repository-url> ~/.dotfiles
cd ~/.dotfiles
git submodule update --init --recursive
```

Then create symbolic links for each configuration. Run these commands from your home directory (`~`).

### Terminal Emulators

#### Alacritty
```bash
mkdir -p ~/.config/alacritty
ln -s ~/.dotfiles/alacritty ~/.config/alacritty
```

#### Ghostty
```bash
mkdir -p ~/.config/ghostty
ln -s ~/.dotfiles/ghostty ~/.config/ghostty
```

### Shell Environments

#### Zsh
```bash
ln -s ~/.dotfiles/zsh ~/.zsh
ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
```

### Text Editors

#### Neovim
Choose one variant. For LazyVim:
```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/neovim/LazyVim ~/.config/nvim
```

For NvChad:
```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/neovim/NvChad2.5 ~/.config/nvim
```

### Version Control

#### Git
```bash
ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/git/gitignore ~/.gitignore
```

### Terminal Multiplexer

#### Tmux
```bash
ln -s ~/.dotfiles/tmux ~/.tmux
ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf
```

### Search Tools

#### Ripgrep
```bash
ln -s ~/.dotfiles/ripgrep/ripgreprc ~/.ripgreprc
ln -s ~/.dotfiles/ripgrep/ripgrepignore ~/.ripgrepignore
```

### Fonts

Install the CommitMono Nerd Font variants to your system fonts directory:

```bash
# On macOS
cp ~/.dotfiles/fonts/*.otf ~/Library/Fonts/

# On Linux
mkdir -p ~/.local/share/fonts
cp ~/.dotfiles/fonts/*.otf ~/.local/share/fonts/
fc-cache -fv
```

### AI Agent System

#### OpenCode
```bash
mkdir -p ~/.config
ln -s ~/.dotfiles/opencode ~/.config/opencode
```

## Managing Configurations

### Updating Dotfiles

To pull latest changes:
```bash
cd ~/.dotfiles
git pull
git submodule update --recursive
```

### Backing Up Existing Configurations

Before creating symlinks, backup any existing configurations:
```bash
# Example for a config file
cp ~/.config/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml.backup
```

### Selective Installation

Only create symlinks for the tools you use. Skip configurations for unused applications.

### Customization

Edit files in `~/.dotfiles` directly. Changes will apply immediately since they are symlinked. Commit and push changes to share across machines.

### Troubleshooting

If a symlink fails, ensure the target directory exists:
```bash
mkdir -p ~/.config/some-app
```

To remove a symlink:
```bash
rm ~/.some-config
```

## Notes About OpenCode AI Agent Setup

The `opencode/` directory contains an AI agent system powered by OpenCode. It includes:

- **Agents**: Specialized AI assistants for different tasks (explore, librarian, oracle, etc.)
- **Skills**: Reusable capabilities and workflows for specific domains
- **Tasks**: Structured task management system
- **Configuration**: JSON files defining agent behaviors and integrations

### Key Components

- `AGENTS.md`: Documentation for available agents
- `skills/`: Directory containing skill definitions
- `agents/`: Agent-specific configurations
- `tasks/`: Task management files

### Usage

The OpenCode system integrates with various development tools and provides intelligent assistance for coding, debugging, and project management. Refer to `opencode/README.md` for detailed setup and usage instructions.

### Dependencies

Ensure Node.js and related tools are installed for full OpenCode functionality. The system uses modern JavaScript and may require additional setup for MCP (Model Context Protocol) integrations.


### Package Management

#### Homebrew
```bash
cd ~/.dotfiles/brew
./restore.sh
```

This runs `brew bundle` using the `Brewfile` in that directory to install all listed packages.
