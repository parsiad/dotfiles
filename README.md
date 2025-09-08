# dotfiles

This repo contains [my](https://parsiad.ca) dotfiles, managed by [chezmoi](https://chezmoi.io).

```bash
chezmoi init parsiad
mkdir -p $HOME/.config/chezmoi
ln -s $HOME/.local/share/chezmoi/.chezmoi.toml $HOME/.config/chezmoi/chezmoi.toml
chezmoi apply
```
