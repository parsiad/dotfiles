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
    fzf --fish | source
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

function bin2dec
    echo "ibase=2 ;           $argv[1]" | bc -l
end
function bin2hex
    echo "ibase=2 ; obase=16; $argv[1]" | bc -l
end
function dec2bin
    echo "          obase=2 ; $argv[1]" | bc -l
end
function dec2hex
    echo "          obase=16; $argv[1]" | bc -l
end
function hex2bin
    echo "ibase=16; obase=2 ; $argv[1]" | bc -l
end
function hex2dec
    echo "ibase=16;           $argv[1]" | bc -l
end

function json-diff
    diff (jq -S . $argv[1] | psub) (jq -S . $argv[2] | psub)
end

function md5sum-dir
    find $argv[1] -type f -exec md5sum {} \; | sort -k 2 | md5sum
end
function sha256sum-dir
    find $argv[1] -type f -exec sha256sum {} \; | sort -k 2 | sha256sum
end
