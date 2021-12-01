# -----------------------------
# Prompt
# -----------------------------

# 色を使用
autoload -Uz colors ; colors
 
function show-git-current-branch-status {
  local branch_name st branch_status
  
  # git 管理されていないディレクトリは何も返さない
  if ! `git status > /dev/null 2>&1` ; then
    return
  fi

  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}("
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}(?"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}(+"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}(!"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}(!(comflict)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}$branch_name)%f"
}
 
# プロンプト表示設定
git_status='`show-git-current-branch-status`'
PROMPT="%F{green}[%~]%f ${git_status}
❯❯❯ "

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