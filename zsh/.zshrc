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
