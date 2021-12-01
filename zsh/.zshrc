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

# awsコマンド補完
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
