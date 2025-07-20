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
   ```
2. Rust# install

```bash
# creat install
cargo install bottom uv fd-find ripgrep bat starship
cargo install --git https://github.com/leokayson/lsd.git
```

2. VSCode

```bash
code --install-extension rust-lang.rust-analyzer uloco.theme-bluloco-dark uloco.theme-bluloco-light llvm-vs-code-extensions.vscode-clangd usernamehw.errorlens mhutchie.git-graph ms-vscode.hexeditor pkief.material-icon-theme cweijan.vscode-office alefragnani.project-manager xshrim.txt-syntax ms-vscode-remote.remote-ssh
```

## On Linux

- Fish

```bash
cargo install --git https://github.com/fish-shell/fish-shell # to build the current development snapshot without cloning
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

# VSCode

## Extension

```bash
code --install-extension rust-lang.rust-analyzer uloco.theme-bluloco-dark uloco.theme-bluloco-light llvm-vs-code-extensions.vscode-clangd usernamehw.errorlens mhutchie.git-graph ms-vscode.hexeditor pkief.material-icon-theme cweijan.vscode-office alefragnani.project-manager xshrim.txt-syntax ms-vscode-remote.remote-ssh
```

## Configs

```plaintext
# Windows
%APPDATA%\Code\User\keybindings.json
# Linux
~/.config/Code/User/keybindings.json
```

# Soft link

```bash
python config.py
```
