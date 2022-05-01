# Prerequisites

## macOS

### Generate keys

### Installation

* [Safari Technology Preview](https://developer.apple.com/safari/technology-preview/)
* Xcode command line tools
* [Homebrew](https://docs.brew.sh/Installation)

``` bash
$ bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Now clone the repository and run [install-macos.sh](install-macos.sh):
``` bash
$ mkdir ~/GitHub
$ git clone git@github.com:doc-smith/dotfiles.git ~/GitHub/dotfiles
$ ~/GitHub/dotfiles/install-macos.sh
```

Install additional programs:
``` bash
$ ~/GitHub/dotfiles/macos/install-stuff.sh
```

And apply sensible defaults:
``` bash
$ ~/GitHub/dotfiles/macos/tweak.sh
```


### Terminal setup

Import a Terminal profile from [macos/terminal](macos/terminal) and make it default.
I was too lazy to properly automate this step.

### Visual Studio Code

Turn on settings sync (Code -> Preferences -> Turn on Settings Sync...) and sign in with the GitHub account.

## Useful tools

* [exa](https://github.com/ogham/exa) is a modern replacement for `ls`
* [bat](https://github.com/sharkdp/bat)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
