
# Set the key mapping style to 'emacs' or 'vi'.
zstyle ':omz:editor' keymap 'vi'

# Auto convert .... to ../..
zstyle ':omz:editor' dot-expansion 'no'

# Set case-sensitivity for completion, history lookup, etc.
zstyle ':omz:*:*' case-sensitive 'no'

# Color output (auto set to 'no' on dumb terminals).
zstyle ':omz:*:*' color 'yes'

# Auto set the tab and window titles.
zstyle ':omz:terminal' auto-title 'yes'

# Set the plugins to load (see $OMZ/plugins/).
zstyle ':omz:load' plugin 'archive' 'git'

# Set the prompt theme to load.
# Setting it to 'random' loads a random theme.
# Auto set to 'off' on dumb terminals.
zstyle ':omz:prompt' theme 'sorin'

# This will make you shout: OH MY ZSHELL!
source "$HOME/.oh-my-zsh/init.zsh"

export DOT_HOME=$HOME/.home
export PATH=$PATH:$DOT_HOME/bin

if [ -d "$HOME/bin" ]; then
	export PATH=$PATH:$HOME/bin
fi

# aliases
source $DOT_HOME/.aliases

# load custom theme
source $DOT_HOME/themes/macrae.zsh-theme

# set environment variables ...
source $DOT_HOME/.environment_variables

# fortune cookie ;-)
source $DOT_HOME/.fortune

source $DOT_HOME/.macports

# add a local .local.zshrc file, if it exists
if [ -f "$HOME/.local.zshrc" ]; then
	source $HOME/.local.zshrc
fi

export EDITOR=`which vim`
# 
# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# source $HOME/.rvm/scripts/rvm
