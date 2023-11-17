## macOS

### Basic Setup

First, install Xcode command line tools (`xcode-select --install`),
[Safari Technology Preview](https://developer.apple.com/safari/resources/)
and [Homebrew](https://docs.brew.sh/Installation):

```
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

The next step is to install [rustup](https://rustup.rs):

```
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Install [JetBrains Mono font](https://www.jetbrains.com/lp/mono/) to use with
Visual Studio Code. That's pretty much it, the rest is automated with
`setup-macos.sh`. Clone this repository and run
[setup-macos.sh](setup-macos.sh):

```
$ mkdir ~/GitHub
$ git clone git@github.com:doc-smith/dotfiles.git ~/GitHub/dotfiles
$ ~/GitHub/dotfiles/setup-macos.sh # --home-setup
```


### Visual Studio Code

Install [Visual Studio Code](https://code.visualstudio.com).

Turn on settings sync (Code -> Preferences -> Turn on Settings Sync...) and
sign in with the GitHub account.

## Terminal

[Terminal profile](conf/my-profile.terminal) is stored in the repository.