# Arvind’s dotfiles

![Screenshot of my shell prompt](img/terminal.gif)

## Installation

**Warning:** If you want to give these dotfiles a try, you should first fork this repository, review the code, and remove things you don’t want or need. Don’t blindly use my settings unless you know what that entails. Use at your own risk!

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~/Projects/dotfiles`, with `~/dotfiles` as a symlink.) The bootstrapper script will pull in the latest version and copy the files to your home folder.

```bash
git clone https://github.com/naiduarvind/dotfiles.git && cd dotfiles && source bootstrap.sh
```

To update, `cd` into your local `dotfiles` repository and then:

```bash
source bootstrap.sh
```

Alternatively, to update while avoiding the confirmation prompt:

```bash
set -- -f; source bootstrap.sh
```

### Specify the `$PATH`

If `~/.path` exists, it will be sourced along with the other files, before any feature testing (such as [detecting which version of `ls` is being used](https://github.com/naiduarvind/dotfiles/)) takes place.

Here’s an example `~/.path` file that adds `/usr/local/bin` to the `$PATH`:

```bash
export PATH="/usr/local/bin:$PATH"
```

### Add custom commands without creating a new fork

If `~/.extra` exists, it will be sourced along with the other files. You can use this to add a few custom commands without the need to fork this entire repository, or to add commands you don’t want to commit to a public repository.

My `~/.extra` looks something like this:

```bash
# Git credentials
# Not in the repository, to prevent people from accidentally committing under my name
GIT_AUTHOR_NAME="Arvind Naidu"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="techmaxed.net@gmail.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

You could also use `~/.extra` to override settings, functions and aliases from my dotfiles repository. It’s probably better to [fork this repository](https://github.com/naiduarvind/dotfiles/fork) instead, though.

### Sensible macOS defaults

When setting up a new Mac, you may want to set some sensible macOS defaults:

```bash
$ ./.macos
```

### Install Homebrew formulae

When setting up a new Mac, you may want to install some common [Homebrew](https://brew.sh/) formulae (after installing Homebrew, of course):

```bash
$ ./brew.sh
```

Some of the functionality of these dotfiles depends on formulae installed by `brew.sh`. If you don’t plan to run `brew.sh`, you should look carefully through the script and manually install any particularly important ones. A good example is Bash/Git completion: the dotfiles use a special version from Homebrew.

### GPG for Git on macOS

#### Setup

1. Install [GPG Keychain](https://gpgtools.org) -- you should do a customized install and deselect GPGMail.
2. Create or import a key (if exists or from another host).
3. Run `gpg --list-secret-keys` and look for sec, use the key ID for the next step.
4. Configure `git` to use GPG -- replace the key with the one from `gpg --list-secret-keys`

```
$ git config --global gpg.program /usr/local/MacGPG2/bin/gpg2
$ git config --global user.signingkey <gpg key ID, e.g. A6B167E1> 
$ git config --global commit.gpgsign true 
```
#### Add public GPG key on Github

```
open https://github.com/settings/keys
```

![Add public GPG key on Github](img/public-gpg-key-on-github.png)

## Author

| [![twitter/rvine_naidu](https://avatars2.githubusercontent.com/u/6829472?s=100&v=4)](http://twitter.com/rvine_naidu "Follow @rvine_naidu on Twitter") |
|---|
| [Arvind Naidu](https://medium.com/@arvindnaidu) |
