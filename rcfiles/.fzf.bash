
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mkaz/.fzf/bin* ]]; then
  export PATH="$PATH:/home/mkaz/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
if [ -e "$HOME/.fzf/shell/key-bindings.bash" ]
then
    source $HOME/.fzf/shell/key-bindings.bash
fi

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --ignore-file /home/mkaz/dotfiles/extras/gitignore'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
#bind -x '"\C-p": vim $(fzf);'
