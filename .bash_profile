# Only run on macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
	# needed for brew
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Only run these on Ubuntu

# if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	# needed for brew to work
# 	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# fi

if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi

# Adding as requested by bash completion module...
# [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

export XDG_CONFIG_HOME="$HOME"/.config

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/jtorrad1/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
. "$HOME/.cargo/env"
