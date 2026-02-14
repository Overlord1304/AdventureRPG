#!/bin/sh
printf '\033c\033]0;%s\a' AdventureRPG
base_path="$(dirname "$(realpath "$0")")"
"$base_path/AdventureRPGLinux.x86_64" "$@"
