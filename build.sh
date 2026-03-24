#!/usr/bin/env zsh

# Initialize rbenv if available
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init -)"
fi

bundle exec rake "book:build[publication]"
