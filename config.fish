if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path /opt/nvim-linux-x86_64/bin
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.pyenv/bin
    
    fish_add_path $HOME/.local/kitty.app

    set -Ux PYENV_ROOT $HOME/.pyenv
    fish_add_path $PYENV_ROOT/bin

    set -Ux BUN_INSTALL $HOME/.bun
    fish_add_path $BUN_INSTALL/bin

    set -Ux NODE_EXTRA_CA_CERTS ~/root-ca.pem.crt

    pyenv init - fish | source
end
