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

# homebrew設定
export PATH=$PATH:/opt/homebrew/bin
export HOMEBREW_CACHE=/opt/homebrew/cache

# -----------------------------
# Customize
# -----------------------------
zshrc_symbolic_link_path=`readlink $HOME/.zshrc`

zshrc_dir_path=$(dirname "${zshrc_symbolic_link_path}")

for rcfile in "${zshrc_dir_path}"/zsh.d/*; do
  [[ ${rcfile} = *.zshrc ]] && source ${rcfile}
done
