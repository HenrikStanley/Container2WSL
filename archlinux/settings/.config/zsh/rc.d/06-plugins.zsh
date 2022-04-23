##
# Plugins

# Add plugins to array in the format of github user / repository name
local -a plugins=(
    Aloxaf/fzf-tab                      # Use FZF for auto-completion
    #marlonrichert/zsh-edit              # Better keyboard shortcuts
    #marlonrichert/zsh-hist              # Edit history from the command line.
    #marlonrichert/zcolors               # Colors for completions and Git
    zsh-users/zsh-autosuggestions       # Inline suggestions
    zdharma-continuum/fast-syntax-highlighting # Command-line syntax highlighting
)

# Speed up the first startup by cloning all plugins in parallel.
# Does not clone plugins already downloaded twice.
znap clone $plugins

# Load each plugin, one at a time.
local p=
for p in $plugins; do
  znap source $p
done

# Plugin settings


