# -----------------------------
# Base
# -----------------------------

# 文字コード指定 
export LANG=ja_JP.UTF-8

# 大文字・小文字を区別しない(大文字を入力した場合は区別する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 自動補完を有効にする
autoload -Uz compinit
compinit -u