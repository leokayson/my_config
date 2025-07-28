# This repo

This repo is just to store my develop habits to sync in many PCs and it includes many personal preferences and shouldn't apply for many people. ofc anyone can use it.

# On Linux

- Fish

```bash
cargo install --git https://github.com/fish-shell/fish-shell # to build the current development snapshot without cloning

sudo apt install -y build-essential ffmpeg 7zip jq poppler-utils fzf imagemagick

```

## On Windows

- cmder

1. config

> %CMDER_ROOT%\config\user_aliases.cmd
>
> %CMDER_ROOT%\vendor\self_init.bat

2. clink cmd

```bash
clink update
```

# Env

1. SW
   ```
   # Rust
   ## On Linux
   curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
   ## On windows
   https://www.rust-lang.org/learn/get-started

   # CMDER
   https://github.com/cmderdev/cmder

   # cb
   https://github.com/Slackadays/Clipboard
   ```
2. Rust

```bash
# creat install
cargo install bottom fd-find du-dust dysk ripgrep bat starship zoxide binsider hexyl ouch
cargo install --git https://github.com/leokayson/lsd.git
cargo install --locked yazi-fm yazi-cli

curl -LsSf https://astral.sh/uv/install.sh | sh
```

2. VSCode

# VSCode

## Extension

```bash
code --install-extension rust-lang.rust-analyzer 
code --install-extension uloco.theme-bluloco-dark uloco.theme-bluloco-light 
code --install-extension llvm-vs-code-extensions.vscode-clangd usernamehw.errorlens mhutchie.git-graph ms-vscode.hexeditor 
code --install-extension pkief.material-icon-theme cweijan.vscode-office alefragnani.project-manager xshrim.txt-syntax ms-vscode-remote.remote-ssh
code --install-extension yo1dog.cursor-align matthewthorning.align-vertically
code --install-extension usernamehw.find-jump enkeldigital.relative-goto
```

## Configs

```plaintext
# Windows
%APPDATA%\Code\User\keybindings.json
%APPDATA%\Code\User\settings.json
# Linux
~/Code/User/keybindings.json
~/Code/User/settings.json
```

# Soft link

```bash
python config.py
```

# SSH

```bash
ssh-keygen -t rsa -b 4096 -f rsa-remote-ssh
chmod 700 ./.ssh
chmod 600 ./.ssh/authorized_keys
chmod 755 ~
```

# Yazi

[Resources | Yazi](https://yazi-rs.github.io/docs/resources)

# NVIM

```bash
https://github.com/neovim/neovim/releases

git clone https://github.com/LazyVim/starter ~/.config/nvim
```
