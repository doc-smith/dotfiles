## macOS

### Basic Setup

First, install Xcode command line tools (`xcode-select --install`).

The next step is to install:

* [Google Chrome](https://www.google.com/chrome)
* [Visual Studio Code](https://code.visualstudio.com)
* [Homebrew](https://docs.brew.sh/Installation)

First, install the GitHub CLI. Then, log in to your GitHub account. Finally, clone this repository.

```
$ /opt/homebrew/bin/brew install gh
$ /opt/homebrew/bin/gh auth login
$ /opt/homebrew/bin/gh repo clone doc-smith/dotfiles ~/GitHub/dotfiles
```

The Terminal profile is saved in the file [conf/my-profile.terminal](conf/my-profile.terminal).
In the Terminal app, just go to Terminal -> Settings -> Profiles, import the profile from this
file, and set it as the default.
