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
# Costumize
# -----------------------------
zshrc_symbolic_link_path=`readlink $HOME/.zshrc`

zshrc_dir_path=$(dirname "${zshrc_symbolic_link_path}")

for rcfile in "${zshrc_dir_path}"/zsh.d/*; do
  [[ ${rcfile} = *.zshrc ]] && source ${rcfile}
done

# direnv
export EDITOR=vim 
export DIRENV_WARN_TIMEOUT=100s
eval "$(direnv hook zsh &> /dev/null)"

# 自作コマンドのPATHを追加
export PATH=$PATH:~/command

# awsコマンド補完
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
