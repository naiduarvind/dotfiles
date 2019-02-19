#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils

# Install some other useful utilities like `sponge`.
brew install moreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils

# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Install `wget` with IRI support.
brew install wget --with-iri

# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim --with-override-system-vi
brew install grep
brew install openssh

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install other useful binaries.
brew install ack
brew install awscli
brew install autojump
brew install eksctl
brew install fx
brew install gcc
brew install git
brew install git-lfs
brew install go
brew install glide
brew install imagemagick --with-webp
brew install jasper
brew install jq
brew install kubectl
brew install kubectx
brew install kubernetes-helm
brew install lua
brew install mkcert
brew install mydumper
brew install mysql
brew install node
brew install nss
brew install packer
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install skaffold
brew install ssh-copy-id
brew install stern
brew install stormssh
brew install skaffold
brew install shpotify
brew install ssdeep
brew install tree
brew install vbindiff
brew install watch
brew install zopfli
brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting

# Remove outdated versions from the cellar.
brew cleanup
