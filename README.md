# 1 This repo

This repo is just to store my develop habits to sync in many PCs and it includes many personal preferences and shouldn't apply for many people. ofc anyone can use it.

I mainly use linux + windows, so cross-platform is much more preferable.

# 2 Env

> ~/env

## 2.1 System environment

> sudo apt install -y build-essential libbz2-dev ffmpeg 7zip jq poppler-utils fzf imagemagick

## 2.2 Rust

> - On Linux:
>
> curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh
>
> - On Windows:
>
> https://www.rust-lang.org/learn/get-started

## 2.3 Rust Crate

> cargo install bottom fd-find du-dust dysk ripgrep bat starship zoxide binsider hexyl ouch
>
> cargo install --git https://github.com/leokayson/lsd.git
>
> cargo install --locked yazi-fm yazi-cli

## 2.4 3rd-patry SW or cannot install in crate.io

> - uv
>
> curl -LsSf https://astral.sh/uv/install.sh | sh
>
> - cb
>
> https://github.com/Slackadays/Clipboard/releases
>
> - neovim
>
> https://github.com/neovim/neovim/releases

# 3 Shell

> - nushell release
>
> https://github.com/nushell/nushell/releases
>
> - starship configure:
>
> ```bash
> mkdir ($nu.data-dir | path join "vendor/autoload")
> starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
> ```
>

# 4 VSCode

## 4.1 Extension

> code --install-extension rust-lang.rust-analyzer
> code --install-extension uloco.theme-bluloco-dark uloco.theme-bluloco-light
> code --install-extension llvm-vs-code-extensions.vscode-clangd usernamehw.errorlens mhutchie.git-graph ms-vscode.hexeditor
> code --install-extension pkief.material-icon-theme cweijan.vscode-office alefragnani.project-manager xshrim.txt-syntax
> code --install-extension ms-vscode-remote.remote-ssh yo1dog.cursor-align matthewthorning.align-vertically
> code --install-extension usernamehw.find-jump enkeldigital.relative-goto

## 4.2 Configs (Can use cloud sync)

> - Windows
>
> %APPDATA%\Code\User\keybindings.json
> %APPDATA%\Code\User\settings.json
>
> - Linux
>
> ~/Code/User/keybindings.json
> ~/Code/User/settings.json

# 5 Config

## 5.1 soft link

```bash
python config.py
```

## 5.2 yazi

```bash
ssh-keygen -t rsa -b 4096 -f rsa-remote-ssh
chmod 700 ./.ssh
chmod 600 ./.ssh/authorized_keys
chmod 755 ~
```

## 5.3 NVIM plugin

> - Windows
>
> git clone https://github.com/LazyVim/starter $env:LOCALAPPDATA\nvim
>
> - Linux
>
> git clone https://github.com/LazyVim/starter ~/.config/nvim
> git clone https://github.com/uloco/bluloco.nvim.git $env:LOCALAPPDATA\nvim-data\lazy

- bloluco.nvim configure

```lua
# Linux:  
# Windows: $env:LOCALAPPDATA\nvim-data\lazy\LazyVim\lua\lazyvim\plugins\colorscheme.lua

# Linux: nvim 
# Windows: nvim $env:LOCALAPPDATA\nvim-data\lazy\LazyVim\lua\lazyvim\plugins\colorscheme.lua
{
  'uloco/bluloco.nvim',
  lazy = false,
  priority = 1000,
  dependencies = { 'rktjmp/lush.nvim' },
  config = function()
    -- your optional config goes here, see below.
  end,
},
```
