#!/bin/bash
< "$1".names xargs -I XXXXXX sh -c "wget -q --show-progress -t 3 --waitretry=3 https://aur.archlinux.org/packages/XXXXXX/ -O webpage/pages/XXXXXX.html"
grep -ir "class=\"broken\"" webpage/pages/
