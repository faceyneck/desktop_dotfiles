# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# ==========================================================
# ==========================================================
# Gemini AI additions ======================================
# ==========================================================
# ==========================================================

# ==========================================
# 1. ENVIROMENT VARIABLES & PATHS
# ==========================================
# Keeps your history clean and long
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=10000
export HISTFILESIZE=20000

# Set default editor 
export EDITOR="vim"
# Set vimrc variable
export VIMRC="~/.config/vim/vimrc"

# ==========================================
# 2. SHELL OPTIONS & BEHAVIORS
# ==========================================
shopt -s autocd 2>/dev/null  # Typing a directory name directly moves into it
shopt -s histappend          # Append to history file, don't overwrite it
shopt -s checkwinsize        # Check window size after each command

# ==========================================
# 3. CUSTOM ALIASES
# ==========================================
alias ..="cd .."
alias ...="cd ../.."
alias ll="ls -alF --color=auto"
alias la="ls -A --color=auto"
alias l="ls -CF --color=auto"
alias grep="grep --color=auto"
# ==========================================
# CONFIGURATION SHORTCUTS
# ==========================================
alias rc="vim ~/.bashrc"                            # Quick edit .bashrc
alias src="source ~/.bashrc"                        # Reload .bashrc changes instantly
alias vrc="vim ~/.config/vim/vimrc"                 # Quick edit Vim config
alias starrc="vim ~/.config/starship/starship.toml" # Quick edit Starship theme
alias wezrc="vim ~/.config/wezterm/wezterm.lua"     # Quick edit WezTerm config
alias tmrc="vim ~/.config/tmux/tmux.conf"           # Quick edit tmux config

# ==========================================
# 4. PROMPT SYSTEM (Starship Initialization)
# ==========================================

# Set custom Starship config file location
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
else
    # Fallback default prompt if starship isn't installed yet
    export PS1="[\u@\h \W]\$ "
fi

# =====================================================================
# =====================================================================
# END GEMINI AI SHENANIGANS ===========================================
# =====================================================================


alias audinux="dnf list --available | grep ycollet | less"

# Appending ~/bin to $PATH:
PATH=$PATH:~/bin
PATH=$PATH:~/scripts
PATH=$PATH:/home/faceyneck/.local/bin:$PATH:/opt/wine-devel/bin:~/.local/share/yabridge

alias hidden='ls -ap | grep "^\..*/$"'
export WINEESYNC=1
export WINEFSYNC=1

# Alias for yazi, and function to exit to the last working directory:

alias yy='y'

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Alias for Fastfetch
alias ff="fastfetch"

# Run Fastfetch each time terminal starts
fastfetch

# Adding in zoxide
eval "$(zoxide init --cmd cd bash)"

# Recursively check for files to source from ~/.bashrc.d
if [ -d ~/.bashrc.d ]; then
    for file in ~/.bashrc.d/*.bashrc; do
        [ -r "$file" ] && source "$file"
    done
    unset file
fi
