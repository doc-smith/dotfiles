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

## Windows

I use a Windows desktop at home when I want to play with x86-64, need an easy access to Linux (through WSL) or want to play a game :-)

My Windows setup is even more spartan. The key parts to get are:

* [winget](https://docs.microsoft.com/en-us/windows/package-manager/winget/)
* [Windows Terminal](https://docs.microsoft.com/en-us/windows/terminal/) (get the preview version)

Install both from Microsoft Store and install things:

```
PS > winget install Microsoft.VisualStudioCode
PS > winget install Git.Git
```

As on macOS, enable settings sync in Visual Studio Code: go to File -> Preferences -> Turn on Settings Sync... and sign in with GitHub.

### SSH keys for Git

Times of Git Bash are long in the past, this is good. Nowadays you can simply open a PowerShell tab in Windows Terminal and run `ssh-keygen`:

```
PS > ssh-keygen -t ed25519 -C "dimitrij.kuznetsov@gmail.com"
```

And there is even an `ssh-agent` service! But you need to enable it first (within admin PowerShell console):

```
PS > Get-Service -Name ssh-agent | Set-Service -StartupType Automatic
PS > Get-Service -Name ssh-agent | Start-Service
PS > Get-Service -Name ssh-agent

Status   Name               DisplayName
------   ----               -----------
Running  ssh-agent          OpenSSH Authentication Agent
```

Now you can `ssh-add` your keys as on Linux or macOS:

```
PS C:\Users\Dmitry> ssh-add .ssh/github_ed25519
Enter passphrase for .ssh/github_ed25519:
Identity added: .ssh/github_ed25519 (dimitrij.kuznetsov@gmail.com)
```

Upload the public key to GitHub and test that everything works:

```
PS > ssh -T git@github.com
Hi doc-smith! You've successfully authenticated, but GitHub does not provide shell access.
```

### Setup Linux in WSL

To get Linux [install WSL](https://docs.microsoft.com/en-us/windows/wsl/install), I prefer the most basic Ubuntu in WSL. With WSL I simply copy the SSH keys for GitHub from the Windows host:

```
$ cp /mnt/c/Users/Dmitry/.ssh/github_ed25519* "${HOME}/.ssh/"
$ chmod 600 ~/.ssh/github_ed25519
$ chmod 644 ~/.ssh/github_ed25519.pub
```

Clone this repository:
```
$ mkdir "${HOME}/GitHub"
$ GIT_SSH_COMMAND='ssh -i ~/.ssh/github_ed25519' git clone git@github.com:doc-smith/dotfiles.git "${HOME}/GitHub/dotfiles"
```