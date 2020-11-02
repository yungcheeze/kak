#!/usr/bin/env bash

plugins_dir="$PWD/autoload/plugins"
plug_kak_destination="$plugins_dir/plug.kak"
[[ -e "$plug_kak_destination"  ]] && echo "plug.kak exists" && exit 0

mkdir -p "$plugins_dir"
git clone https://github.com/alexherbo2/plug.kak.git "$plug_kak_destination"
