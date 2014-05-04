export RBENV_ROOT=/usr/local/rbenv
export PATH="$RBENV_ROOT/bin:$PATH"

eval "$(rbenv init -)"
echo "gem: --no-ri --no-rdoc" > ~/.gemrc