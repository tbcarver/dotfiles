
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Ensure agent is running
ssh-add -l &>/dev/null
if [[ "$?" == 2 ]]; then
    # Could not open a connection to your authentication agent.

    # Load stored agent connection info.
    test -r ~/.ssh-agent && \
        eval "$(<~/.ssh-agent)" >/dev/null

    ssh-add -l &>/dev/null
    if [[ "$?" == 2 ]]; then
        # Start agent and store agent connection info.
        (umask 066; ssh-agent > ~/.ssh-agent)
        eval "$(<~/.ssh-agent)" >/dev/null
    fi
fi

# Load identities
ssh-add -l &>/dev/null
if [[ "$?" == 1 ]]; then
    # The agent has no identities.
    # Time to add one.
    ssh-add ~/.ssh/id_rsa
fi

# Setup keychain
# is this an interactive shell?
if [[ $- == *i* ]]; then
    # set up ssh key server
    if [[ -x /usr/bin/keychain ]]; then
        eval $(keychain --eval --agents gpg B7B68B684BFF65D93A24FFC85619EB9C2B37E349 -q)
        eval $(keychain --agents ssh -q)
        export GPG_TTY=$(tty)
    fi
fi


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
