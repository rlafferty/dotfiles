# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Bundler plugin fix
export UNBUNDLED_COMMANDS=knife

ZSH_THEME="gianu"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(aws brew colorize common-aliases docker git go history jump rvm zsh_reload zsh-completions)

# User configuration
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Install Tmux Package Manager (TPM)
if [[ -d "${HOME}/plugins/tpm" ]]; then
    git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm && \
        ${HOME}/.tmux/plugins/tpm/bin/install_plugins
fi

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='vim'
 fi

# Trash support
alias t=trash

# Cask Update
alias cask_update="curl -s https://gist.githubusercontent.com/atais/5d3ec79e67f221cb55b7/raw/f6e6b647e6f90939c016ba88e591529d143cb33d/cash_upgrade.sh | bash /dev/stdin"

# direnv
eval "$(direnv hook zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias config="/usr/local/bin/git --git-dir=${HOME}/.cfg/ --work-tree=${HOME}"

# always in tmux config
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Local config
#export PATH="${PATH}:${HOME}/bin"
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

autoload -Uz compinit
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
  compinit
else
  compinit -C
fi
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Aliases to enhance defaults
# https://remysharp.com/2018/08/23/cli-improved
alias cat='bat'
alias ping='prettyping --nolegend'
# alias preview="fzf --preview 'bat --color \"always\" {}'"
# export FZF_DEFAULT_OPTS="--bind 'ctrl-t:execute(vim {1} < /dev/tty)+abort'"
alias top="htop"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"
alias help="tldr"

fo() {
  local out file key
  IFS=$'\n' out=($(fzf-tmux --preview 'bat --color "always" {}' --query="$1" --exit-0 --expect=ctrl-o,ctrl-e))
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# because common-aliases does this...
unalias fd

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
