# Setup fzf
# ---------
if [[ ! "$PATH" == */home/mkaz/.fzf/bin* ]]; then
  export PATH="$PATH:/home/mkaz/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/mkaz/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/mkaz/.fzf/shell/key-bindings.bash"

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'
