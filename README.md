# My dotfiles
Personal configuration files, managed with symlinks.

## Usage

Run these at dotfiles/ (so .stowrc is picked up).

**To list all available dotfiles**

```bash
./scripts/gen-filelist.sh
```
**To check the linked state of packages before install**

```bash
stow -n -vv bash git vim tmux
sudo stow -n -vv --target=/ ssh
```

If the output contains "LINK: * => * ", it indicates the package is not yet installed.

**To install links to $HOME**

```bash
stow bash git vim tmux
```

For config files outside $HOME (e.g., system configs), specify --target:

```bash
sudo stow --target=/ ssh
```

**To remove the symlinks created by a package**

```bash
stow -D bash git vim tmux
sudo stow -D --target=/ ssh
```

**To update the link state** (after adding or removing files in a package)

```bash
stow -R bash git vim tmux
sudo stow -R --target=/ ssh
```

### ⚠️ DANGER BEHAVIORS

**To move real dotfiles from $HOME into ./bash/, OVERWRITING the repo**

```bash
stow --adopt bash
```

The real dotfiles from $HOME will be moved. The same-named source files in the repo will be overwritten, not combined.

## Notice

A third-party GitHub proxy is used in .vimrc for vim-plug:

```vim
let g:plug_url_format = 'https://ghproxy.net/https://github.com/%s.git'
```
