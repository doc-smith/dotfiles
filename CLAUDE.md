# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Running the setup

```bash
./setup.sh                  # full install (updates Homebrew, installs formulae/casks, creates symlinks)
./setup.sh --no-brew-update # skip `brew update`
```

`setup.sh` dispatches to `setup-macos.sh` (the only supported OS is macOS).

## Linting shell scripts

```bash
shellcheck setup.sh setup-macos.sh common.sh
shellcheck conf/zsh/zshrc conf/zsh/zshenv
shellcheck conf/bash/bashrc conf/bash/bash_profile conf/bash/profile
```

## Architecture

- **`setup.sh`** — entry point; checks OS and delegates to `setup-macos.sh`
- **`setup-macos.sh`** — installs Homebrew formulae/casks, then calls `create_symlinks()`
- **`common.sh`** — shared helpers (`die`, `stderr`, `quietly`, `ask_sudo`, `revoke_sudo`); sourced by both setup scripts
- **`conf/`** — all config files that get symlinked into `$HOME` by `create_symlinks()`

Symlink targets created by `create_symlinks()`:

| `$HOME` path | Repo path |
|---|---|
| `~/.zshrc` | `conf/zsh/zshrc` |
| `~/.zshenv` | `conf/zsh/zshenv` |
| `~/.bashrc` | `conf/bash/bashrc` |
| `~/.bash_profile` | `conf/bash/bash_profile` |
| `~/.profile` | `conf/bash/profile` |
| `~/.gitconfig` | `conf/gitconfig` |
| `~/.vimrc` | `conf/vimrc` |
| VS Code `settings.json` | `conf/vscode/user-settings.json` |

The Terminal.app profile (`conf/my-profile.terminal`) is not symlinked — it must be imported manually via Terminal → Settings → Profiles.
