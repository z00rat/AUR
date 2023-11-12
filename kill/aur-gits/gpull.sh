#!/bin/bash
< "$1".names xargs -I XXXXXX sh -c 'git clone https://aur.archlinux.org/XXXXXX.git ./packages/XXXXXX && sleep 0'
