set -x CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1
set -x EDITOR nvim
set -x PATH $PATH $HOME/bin

# Create Miniconda startup script if it does not exist to reduce shell startup time
set -l conda_bin /opt/miniconda3/bin
if test -e $conda_bin
    set -l conda_hook ~/.config/fish/conf.d/conda.fish
    set -x PATH $PATH $conda_bin
    if not test -e $conda_hook # -o $conda_bin/conda -nt $conda_hook
        $conda_bin/conda shell.fish hook >$conda_hook
    end
    source $conda_hook
end

if not status --is-interactive
    return
end

function fish_user_key_bindings
    fzf_key_bindings
    fish_vi_key_bindings
end

eval (direnv hook fish | source)
eval (zoxide init fish | source)

if type -q batcat
    alias bat batcat
end
if type -q btop
    alias top btop
end
if type -q colordiff
    alias diff colordiff
end
if type -q exa
    alias ls='exa -H -g' || alias ls='ls --color=auto'
end
if type -q nvim
    alias vim=nvim
    set -x MANPAGER 'nvim +Man!'
end

alias decrypt-id_rsa 'gpg --decrypt ~/.password-store/keys/id_rsa.gpg | ssh-add -t 60 -'
alias g git
alias git-authors 'git shortlog --email --summary --numbered'
alias git-sha 'git rev-parse --short HEAD'
alias l 'ls -l'
alias la 'ls -la'
alias ll l
alias pacman-age 'head -n1 /var/log/pacman.log | cut -d'\'' '\'' -f1 | cut -c 2-'
alias pacman-rm-orphans 'sudo pacman -Rns $(pacman -Qtdq)'
alias services 'systemctl list-unit-files --type=service'
alias vi vim
