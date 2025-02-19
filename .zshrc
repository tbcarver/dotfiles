# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Right and left ctrl arrow keys
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Alias
if command -v php > /dev/null 2>&1; then
    alias pa='sudo -u www-data php artisan'
    alias tinker='sudo -u www-data php artisan tinker'
fi
alias gpu='git pull'
alias gps='git push'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git commit -m'
alias gca='git commit -am'

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
#setopt histnorecord
#setopt appendhistory
setopt INC_APPEND_HISTORY
#setopt SHARE_HISTORY
#setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Editor
export EDITOR=nano

if [ -f "$HOME/.keychain-setup.sh" ]; then
   source "$HOME/.keychain-setup.sh"
fi

# # Fix gpg signing issue
# # https://stackoverflow.com/questions/68946047/signing-issue-with-export-gpg-tty-tty
# export GPG_TTY=$(tty)

# # Ensure agent is running
# ssh-add -l &>/dev/null
# if [[ "$?" == 2 ]]; then
#     # Could not open a connection to your authentication agent.

#     # Load stored agent connection info.
#     test -r ~/.ssh-agent && \
#         eval "$(<~/.ssh-agent)" >/dev/null

#     ssh-add -l &>/dev/null
#     if [[ "$?" == 2 ]]; then
#         # Start agent and store agent connection info.
#         (umask 066; ssh-agent > ~/.ssh-agent)
#         eval "$(<~/.ssh-agent)" >/dev/null
#     fi
# fi

# # Load identities
# ssh-add -l &>/dev/null
# if [[ "$?" == 1 ]]; then
#     # The agent has no identities.
#     # Time to add one.
#     ssh-add ~/.ssh/id_rsa
# fi

# # Setup keychain
# # is this an interactive shell?
# if [[ $- == *i* ]]; then
#     # set up ssh key server
#     if [[ -x /usr/bin/keychain ]]; then
#         # eval $(keychain --eval --agents gpg B7B68B684BFF65D93A24FFC85619EB9C2B37E349 -q)
#         eval $(keychain --agents ssh -q)
#     fi
# fi

# OLD: Set the mtu for the fashionphile vpn of 1400
# Set the mtu for the current windows adapter
# netsh interface ipv4 show subinterfaces
if test -e /sys/class/net/eth0/mtu; then
	if [[ ! $(cat /sys/class/net/eth0/mtu) == "1380" ]]; then
		if sudo ip link set dev eth0 mtu 1380 type noop 2>/dev/null; then
			sudo ip link set eth0 mtu 1380
		fi
	fi
fi

# export TERM=xterm-256color

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ $(whoami) == "vscode" ]]; then
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=17
fi

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  \. "$NVM_DIR/nvm.sh"
  \. "$NVM_DIR/bash_completion"

  if [[ -f package.json ]]; then
      node_version=$(jq -r '.engines.node' package.json)
      if [[ -n "$node_version" && ! "$node_version" =~ ^null ]]; then
          main_version=$(echo "$node_version" | grep -oP '(?<=\>=)\d+' | cut -d '.' -f 1)
          nvm use "$main_version" &> /dev/null
      fi
  fi
fi

# Check if the gh copilot extension is installed and load aliases accordingly
if command -v gh &> /dev/null; then
  if gh extension list | grep -q 'github/gh-copilot'; then
    copilot_shell_suggest() {
      gh copilot suggest -t shell "$@"
    }
    alias '??'='copilot_shell_suggest'

    copilot_shell_explain() {
      gh copilot explain "$@"
    }
    alias '???'='copilot_shell_explain'

    # Function to handle Git command suggestions
    copilot_git_suggest() {
      gh copilot suggest -t git "$@"
    }
    alias 'git?'='copilot_git_suggest'

    # Function to handle GitHub CLI command suggestions
    copilot_gh_suggest() {
      gh copilot suggest -t gh "$@"
    }
    alias 'gh?'='copilot_gh_suggest'
  fi
fi
