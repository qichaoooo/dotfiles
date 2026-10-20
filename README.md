# My dotfiles
Personal configuration files, managed with symlinks. 

## you can do these in addr $PWD
**To check dotfiles which could install**

	./scripts/gen-filelist.sh

**To check ./bash/ linked state before install**

	stow -n -vv bash
if the output contains "LINK: * => * " means not installed

**To install ./bash links to $HOME**

	stow bash

**To remove the symlinks ./bash created in $HOME**

	stow -D bash

**To update link state**

	stow -R bash

### ⚠️DANGER BEHAVIORS
**To move real dotfiles from $HOME into ./bash/, OVERWRITING**

	stow --adopt bash
the real dotfiles from $HOME will be move

the same-named source files will be overwritten, not combined

## Notice
.vimrc use third-party GitHub proxy

	let g:plug_url_format = 'https://ghproxy.net/https://github.com/%s.git'
