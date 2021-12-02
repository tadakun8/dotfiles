# -----------------------------
# anyenv
# -----------------------------

# anyenv設定
eval "$(anyenv init -)" &> /dev/null

# pyenv設定(https://github.com/anyenv/anyenv/issues/89)
export PATH=$PYENV_ROOT/shims:$PATH
