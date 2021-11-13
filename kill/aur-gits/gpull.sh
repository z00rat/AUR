#!/bin/bash
< "$1".names xargs -n 1 -I XXXXXX sh -c 'git clone https://aur.archlinux.org/XXXXXX.git ./packages/XXXXXX && sleep 2'
