# dotfiles and dotfolders
~/.files

# install
- (Linux with GUI) Install powerlevel10k **MesloLGS NF** fonts
  [https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)
-
		  sudo apt-get update -yq \
			&& sudo apt-get install -yq fontconfig \
			&& mkdir -p ~/.fonts \
			&& wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P ~/.fonts \
			&& wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P ~/.fonts \
			&& wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P ~/.fonts \
			&& wget -q --show-progress https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P ~/.fonts \
			&& fc-cache -f -v \
			&& fc-list | grep "MesloLGS NF"

- `sudo apt update && sudo apt install zsh yadm keychain`    
- `git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k`    
- `yadm clone git@github.com:tbcarver/dotfiles.git`
- Change login shell
  `chsh -s /bin/zsh`

# usage
use yadm for all git commands i.e. yadm pull
