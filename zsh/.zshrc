zshrc_symbolic_link_path=`readlink $HOME/.zshrc`

zshrc_dir_path=$(dirname "${zshrc_symbolic_link_path}")

for rcfile in "${zshrc_dir_path}"/zsh.d/*; do
  [[ ${rcfile} = *.zshrc ]] && source ${rcfile}
done

# direnv
export EDITOR=vim 
export DIRENV_WARN_TIMEOUT=100s
eval "$(direnv hook zsh &> /dev/null)"

# 終了ステータスが0以外の場合にステータスを表示する
# setopt print_exit_value

# 自作コマンドのPATHを追加
export PATH=$PATH:~/command

# 文字コード指定 
export LANG=ja_JP.UTF-8

# homebrew設定
export PATH=$PATH:/opt/homebrew/bin
export HOMEBREW_CACHE=/opt/homebrew/cache

# anyenv設定
eval "$(anyenv init -)" &> /dev/null # (https://github.com/anyenv/anyenv/issues/89)

# pyenv設定(https://github.com/anyenv/anyenv/issues/89)
export PATH=$PYENV_ROOT/shims:$PATH

# android studio
ANDROID_HOME=${HOME}/Library/Android/sdk
PATH=${PATH}:${ANDROID_HOME}/tools
PATH=${PATH}:${ANDROID_HOME}/platformtools

# 大文字・小文字を区別しない(大文字を入力した場合は区別する)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 自動補完を有効にする
autoload -Uz compinit
compinit -u

# awsコマンド補完
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
