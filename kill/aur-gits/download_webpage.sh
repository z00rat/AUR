#!/bin/bash
/bin/ls packages | xargs -I XXXXXX sh -c "wget -q --show-progress -t 3 --waitretry=3 https://aur.archlinux.org/packages/XXXXXX/ -O webpage/XXXXXX.html  &&  prettier -w webpage/XXXXXX.html  &&  grep -ir \"class=\"broken\"\" webpage/XXXXXX.html"
