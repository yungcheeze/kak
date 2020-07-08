#!/usr/bin/env bash

plug_kak_destination="$PWD/plugins/plug.kak"
[[ -e "$plug_kak_destination"  ]] && echo "plug.kak exists" && exit 0

mkdir -p "$PWD/plugins"
git clone https://gitlab.com/andreyorst/plug.kak.git "$plug_kak_destination"
