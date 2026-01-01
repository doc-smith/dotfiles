# Dotfiles (macOS)

This repo bootstraps my macOS development setup by installing Homebrew formulae/casks and linking shell/editor config files into `$HOME`.

## What it installs

Homebrew formulae and casks are defined in `setup-macos.sh`. Current highlights:

- Shell + CLI: bash, zsh, fzf, ripgrep, shellcheck, tlrc, tmux
- Languages: golang, python3
- Apps: ChatGPT, Codex, Visual Studio Code

## Quick start (new Mac)

1. Install Xcode Command Line Tools:
   - `xcode-select --install`
2. Install Homebrew:
   - https://docs.brew.sh/Installation
3. Create a new SSH key and add it to GitHub:
   - https://docs.github.com/en/authentication/connecting-to-github-with-ssh
4. Install GitHub CLI, log in, and clone:

```bash
brew install gh
gh auth login
gh repo clone doc-smith/dotfiles ~/GitHub/dotfiles
```

## Install

```bash
cd ~/GitHub/dotfiles
./setup.sh
```

Optional flags:

- `--no-brew-update` skips `brew update`

## What gets linked

Symlinks created in `$HOME`:

- `~/.zshrc` -> `conf/zsh/zshrc`
- `~/.zshenv` -> `conf/zsh/zshenv`
- `~/.gitconfig` -> `conf/gitconfig`
- `~/.vimrc` -> `conf/vimrc`
- VS Code settings -> `conf/vscode/user-settings.json`

## Terminal profile

The Terminal profile lives at `conf/my-profile.terminal`.
Import it in Terminal → Settings → Profiles and set it as the default.

## Notes

- This repo currently targets macOS only.
- Homebrew is discovered from your `PATH`.
