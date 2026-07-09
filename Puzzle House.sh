#!/bin/sh
printf '\033c\033]0;%s\a' Puzzle House
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Puzzle House.x86_64" "$@"
