#!/usr/bin/env bash

to_fmt="$(cat -)"
black_opts="$@"

if echo "$to_fmt" | black - > /dev/null; then
  echo "$to_fmt" | black $black_opts -
else
  echo "$to_fmt" | black-macchiato
fi

