# -----------------------------
# awscli
# -----------------------------

# コマンド補完
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws
