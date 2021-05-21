# alias
alias ls='ls -FG'
alias history="fc -lt '%F %T' 1"

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

# -----------------------------
# History
# -----------------------------
# 基本設定
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=1000000

# 同時に起動しているzshの間でhistoryを共有する
setopt share_history

# historyに日付を表示 例.2016-11-25 10:00:00 free -m
export HISTTIMEFORMAT='%F %T '

# 履歴をすぐに追加する
setopt inc_append_history

# -----------------------------
# Prompt
# -----------------------------

# 色を使用
autoload -Uz colors ; colors

# function left-prompt {
#   name_t='179m%}'      # user name text clolr
#   name_b='000m%}'    # user name background color
#   path_t='255m%}'     # path text clolr
#   path_b='031m%}'   # path background color
#   arrow='087m%}'   # arrow color
#   text_color='%{\e[38;5;'    # set text color
#   back_color='%{\e[30;48;5;' # set background color
#   reset='%{\e[0m%}'   # reset
#   sharp='\uE0B0'      # triangle
  
#   user="${back_color}${name_b}${text_color}${name_t}"
#   dir="${back_color}${path_b}${text_color}${path_t}"
#   echo "${user}%n%#@%m${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}→ ${reset}"
# }

# PROMPT=`left-prompt` 


# プロンプト表示設定
PROMPT="%F{green}[%~]%f 
❯❯❯ "

# 右プロンプトにカレントブランチを表示する 
function rprompt-git-current-branch {
  local branch_name st branch_status
  
  # git 管理されていないディレクトリは何も返さない
  if ! `git status > /dev/null 2>&1` ; then
    return
  fi

  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}
 
# プロンプトの右側にメソッドの結果を表示させる
RPROMPT='`rprompt-git-current-branch`'

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

# コマンドの実行ごとに改行
function precmd() {
    # Print a newline before the prompt, unless it's the
    # first prompt in the process.
    if [ -z "$NEW_LINE_BEFORE_PROMPT" ]; then
        NEW_LINE_BEFORE_PROMPT=1
    elif [ "$NEW_LINE_BEFORE_PROMPT" -eq 1 ]; then
        echo ""
    fi
}