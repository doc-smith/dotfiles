## macOS

### Basic Setup

First, install Xcode command line tools (`xcode-select --install`).

The next step is to install:

* [Google Chrome](https://www.google.com/chrome)
* [Visual Studio Code](https://code.visualstudio.com)
* [Homebrew](https://docs.brew.sh/Installation)

Generate [a new SSH key pair](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
on your new machine and [add the public key to your GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

Then, install the GitHub CLI. Then, log in to your GitHub account. Finally, clone this repository.

```
$ /opt/homebrew/bin/brew install gh
$ /opt/homebrew/bin/gh auth login
$ /opt/homebrew/bin/gh repo clone doc-smith/dotfiles ~/GitHub/dotfiles
```

The Terminal profile is saved in the file [conf/my-profile.terminal](conf/my-profile.terminal).
In the Terminal app, just go to Terminal -> Settings -> Profiles, import the profile from this
file, and set it as the default.
