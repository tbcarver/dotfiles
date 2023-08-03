#!/bin/bash

if [ -n "$TERM" ]; then
  ssh_config_file="$HOME/.ssh/config"

  if [ -f "$ssh_config_file" ]; then
    identity_files=$(grep -i "IdentityFile" ~/.ssh/config | awk '{print $2}')

    if grep -q "UseKeychain yes" "$ssh_config_file" \
      && ! grep -q "IgnoreUnknown UseKeychain" "$ssh_config_file"; then
      sed -i -e '/UseKeychain yes/i IgnoreUnknown UseKeychain' "$ssh_config_file"
    fi
  else
    identity_files=$(find ~/.ssh -name "id_*" ! -name "*.pub" -type f)
  fi

  if [[ -n "$identity_files" ]]; then
    identity_files=${identity_files/#\~/$HOME}
    for identity_file in $identity_files; do
      eval $(keychain --eval --agents ssh -q --inherit any-once $identity_file)
    done
  fi
fi

# Set GPG_TTY to allow for enter passphrase screen in terminal
export GPG_TTY=$(tty)
eval $(keychain --eval --agents gpg --inherit any-once -q)
