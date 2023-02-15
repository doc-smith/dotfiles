## macOS

### Basic Setup

First, install Xcode command line tools (`xcode-select --install`) and  [Homebrew](https://docs.brew.sh/Installation):

``` bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

The next step is to install [Go](https://go.dev/dl/) and [rustup](https://rustup.rs):

``` bash
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

That's pretty much it, the rest is automated with `setup-macos.sh`. Clone the repository and run [setup-macos.sh](setup-macos.sh):
``` bash
$ mkdir ~/GitHub
$ git clone git@github.com:doc-smith/dotfiles.git ~/GitHub/dotfiles
$ ~/GitHub/dotfiles/setup-macos.sh # --home-setup
```

### Visual Studio Code

Turn on settings sync (Code -> Preferences -> Turn on Settings Sync...) and sign in with the GitHub account.
