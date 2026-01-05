set -x CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1
set -x EDITOR nvim
set -x PATH $PATH $HOME/bin

# Some display managers do not set SSH_AUTH_SOCK
if set -q XDG_RUNTIME_DIR; and not set -q SSH_AUTH_SOCK
    set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
end

# Create Miniconda startup script if it does not exist to reduce shell startup time
set -l conda_bin /opt/miniconda3/bin
if test -e $conda_bin
    set -l conda_hook ~/.config/fish/conf.d/conda.fish
    set -x PATH $PATH $conda_bin
    if not test -e $conda_hook
        $conda_bin/conda config --set auto_activate_base false
        $conda_bin/conda shell.fish hook >$conda_hook
    end
    source $conda_hook
end

if not status --is-interactive
    return
end

eval (direnv hook fish | source)
eval (zoxide init fish | source)

fish_vi_key_bindings
bind ctrl-e edit_command_buffer

if type -q batcat
    alias bat batcat
end
if type -q btop
    alias top btop
end
if type -q colordiff
    alias diff colordiff
end
if type -q eza
    alias ls='eza -H -g' || alias ls='ls --color=auto'
end
if type -q nvim
    alias vim=nvim
    set -x MANPAGER 'nvim +Man!'
end

alias d 'pass keys/id_rsa | ssh-add -t 600 -'
alias f sftp
alias g git
alias l 'ls -l'
alias p pacman
alias s ssh
alias v vim

alias enc 'gpg -r E97D1AB234818A28 --encrypt'
alias dec 'gpg --decrypt'

alias la 'l -a'
alias ll l

alias pac-age 'head -n1 /var/log/pacman.log | cut -d'\'' '\'' -f1 | cut -c 2-'
alias pac-rmo 'sudo pacman -Rns $(pacman -Qtdq)'

alias pydbg 'python -m ipdb'

alias services 'systemctl list-unit-files --type=service'

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

function pac-sze
    pacman -Qi | awk '
    /^Name[[:space:]]*:/ {line=$0; sub(/.*: */,"",line); name=line}
    /^Installed Size[[:space:]]*:/ {
      line=$0; sub(/.*: */,"",line); split(line,a," ");
      size=a[1]; unit=a[2];
      if(unit=="KiB") bytes=size*1024;
      else if(unit=="MiB") bytes=size*1024*1024;
      else if(unit=="GiB") bytes=size*1024*1024*1024;
      else bytes=size;
      printf "%020d %s %s %s\n", bytes, size, unit, name
    }
    ' | sort -nr | awk '{print $2" "$3" "$4}'
end

function md5sum-dir
    find $argv[1] -type f -exec md5sum {} \; | sort -k 2 | md5sum
end
function sha256sum-dir
    find $argv[1] -type f -exec sha256sum {} \; | sort -k 2 | sha256sum
end
