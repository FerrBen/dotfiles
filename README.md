# FerrBen's Dotfiles

This repository contains my personal configuration files (dotfiles), managed using [GNU Stow](https://www.gnu.org/software/stow/). Stow is a symlink farm manager which takes distinct packages of software and symlinks them into place.

## Prerequisites

Ensure you have the following software installed before proceeding:

- [GNU Stow](https://www.gnu.org/software/stow/)
- [Git](https://git-scm.com/)
- [Zsh](https://www.zsh.org/)
- [Oh My Zsh](https://ohmyz.sh/)
- [Wezterm](https://wezfurlong.org/wezterm/)
- [tmux](https://github.com/tmux/tmux/wiki)
- [Aerospace](https://github.com/nikitabobko/AeroSpace)

## Installation

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/FerrBen/dotfiles.git ~/dotfiles
    ```

2.  **Create the secrets file:**

    These dotfiles expect a `~/.secrets` file for storing sensitive information like API keys. Create this file and add your secrets. The zsh configuration will source this file if it exists.

    ```bash
    # Example for ~/.secrets
    export GEMINI_API_KEY="your_api_key_here"
    ```

3.  **Stow the configurations:**

    Navigate to the `dotfiles` directory and use `stow` to create the necessary symlinks in your home directory.

    ```bash
    cd ~/dotfiles
    stow *
    ```

    This command will symlink the configurations for all the packages (zsh, git, tmux, etc.) into your home directory.
