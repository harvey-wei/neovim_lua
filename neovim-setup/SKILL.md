---
name: neovim-setup
description: Install Neovim and deploy a full Lua-based config with lazy.nvim, LSP, DAP, Treesitter, Telescope, and 25+ plugins on a fresh Ubuntu machine. Use when the user asks to set up Neovim, install Neovim plugins, configure Neovim on Ubuntu, or bootstrap a new dev environment.
---

# Neovim Setup on Ubuntu

Bootstraps a complete Neovim development environment on a fresh Ubuntu machine using the config at `https://github.com/harvey-wei/neovim_lua.git` (branch: `ubuntu`).

## Prerequisites Check

Before starting, verify the target is Ubuntu:

```bash
lsb_release -a 2>/dev/null || cat /etc/os-release
```

## Phase 1: System Dependencies

Run all of these — they are required by the plugins (Treesitter compilers, Telescope grep, DAP debuggers, Nerd Font rendering, etc.):

```bash
sudo apt update && sudo apt install -y \
  build-essential cmake git curl wget unzip \
  ripgrep fd-find \
  python3 python3-pip python3-venv \
  nodejs npm \
  golang-go \
  zsh \
  luarocks
```

Create the `fd` symlink (Ubuntu packages it as `fdfind`):

```bash
[ ! -f /usr/local/bin/fd ] && sudo ln -s $(which fdfind) /usr/local/bin/fd
```

## Phase 2: Install Neovim (stable >= 0.11)

The config uses `vim.lsp.config()` / `vim.lsp.enable()` which require Neovim 0.11+.

```bash
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.tar.gz
nvim --version | head -1
```

Confirm output shows `NVIM v0.11` or later.

## Phase 3: Install Nerd Font (required by devicons, lualine, neo-tree)

```bash
mkdir -p ~/.local/share/fonts
cd /tmp
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz -C ~/.local/share/fonts
fc-cache -fv
rm JetBrainsMono.tar.xz
```

Then configure the terminal emulator to use "JetBrainsMono Nerd Font".

## Phase 4: Deploy Neovim Config

```bash
# Back up any existing config
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak.$(date +%s)

git clone -b ubuntu https://github.com/harvey-wei/neovim_lua.git ~/.config/nvim
```

## Phase 5: First Launch — Plugin Installation

Lazy.nvim auto-bootstraps on first run. Launch headlessly to install everything:

```bash
nvim --headless "+Lazy! sync" +qa
```

Then install Treesitter parsers:

```bash
nvim --headless "+TSUpdateSync" +qa
```

## Phase 6: Mason — LSP Servers & DAP Adapters

Mason auto-installs on load, but to ensure all tools are ready:

```bash
nvim --headless "+MasonInstall lua-language-server pylsp clangd delve debugpy bash-debug-adapter codelldb" +qa
```

Verify Mason binaries are on PATH (the config prepends `~/.local/share/nvim/mason/bin`):

```bash
ls ~/.local/share/nvim/mason/bin/
```

## Phase 7: Optional — Shell Setup (oh-my-zsh + p10k)

The repo includes a `zshrc` file. To use it:

```bash
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install zsh plugins referenced in zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/supercrabtree/k ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/k
git clone https://github.com/z-shell/zsh-eza ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-eza
git clone https://github.com/jimeh/zsh-peco-history ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-peco-history

# Install eza (modern ls)
sudo apt install -y eza || cargo install eza

# Install lazygit (used by ,tg keybinding)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Deploy the zshrc (back up existing)
[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.bak.$(date +%s)
cp ~/.config/nvim/zshrc ~/.zshrc
```

Review `~/.zshrc` and adjust conda/CUDA paths for the target machine.

## Phase 8: Verification

Open Neovim and run these checks:

```
:checkhealth              " Overall health
:Lazy                     " All plugins should show ✓
:Mason                    " lua_ls, pylsp, clangd, debugpy, delve should show installed
:TSInstallInfo            " Parsers for c, cpp, cuda, python, lua, etc. should show installed
```

Open a Python file and verify:
- LSP attaches (status line shows server name, or `:LspInfo`)
- Completion works (`<C-Space>` to trigger blink.cmp)
- `,d` group shows debug keybindings via which-key

## Quick Reference: Key Bindings

Leader key is `,` (comma).

| Prefix | Group | Examples |
|--------|-------|---------|
| `,f` | Telescope | `,ff` find files, `,fg` live grep, `,fb` buffers |
| `,d` | Debug | `,dc` continue, `,dt` toggle breakpoint, `,di` step into |
| `,t` | Terminal | `,tt` toggle, `,tn` new, `,tg` lazygit |
| `,h` | Git Hunk | `,hs` stage, `,hr` reset, `,hp` preview |
| `,e` | Explorer | `,e` toggle neo-tree |
| `,a` | AI/Claude | `,ac` toggle Claude, `,as` send selection |

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Icons show as `?` boxes | Set terminal font to a Nerd Font |
| `pylsp` not found | Run `:MasonInstall pylsp` or check `~/.local/share/nvim/mason/bin/` |
| Treesitter errors on open | Run `:TSUpdate` inside Neovim |
| DAP won't start for Python | Ensure `debugpy` is installed: `:MasonInstall debugpy` |
| `vim.lsp.config` errors | Neovim version is < 0.11; upgrade Neovim |
