## macOS

### Basic Setup

* Xcode command line tools
* [Homebrew](https://docs.brew.sh/Installation)

``` bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Now clone the repository and run [setup-macos.sh](setup-macos.sh):
``` bash
$ mkdir ~/GitHub
$ git clone git@github.com:doc-smith/dotfiles.git ~/GitHub/dotfiles
$ ~/GitHub/dotfiles/setup-macos.sh # --home-setup
```

### Terminal setup

Import a Terminal profile from [conf/terminal](conf/terminal) and make it default. I was too lazy to properly automate this step.

### Visual Studio Code

Turn on settings sync (Code -> Preferences -> Turn on Settings Sync...) and sign in with the GitHub account.
