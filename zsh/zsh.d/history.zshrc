# -----------------------------
# History
# -----------------------------
# 基本設定
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000

# 同時に起動しているzshの間でhistoryを共有する
setopt share_history

# historyに日付を表示 
# 例.2016-11-25 10:00:00 command -option ・・・
export HISTTIMEFORMAT='%F %T '

# 履歴をすぐに追加する
setopt inc_append_history
