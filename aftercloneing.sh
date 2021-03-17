#!/bin/bash
# https://gist.github.com/slavafomin/08670ec0c0e75b500edbaa5d43a5c93c

msg2 "submodule status..."
git submodule status
msg2 "submodule update --init"
git submodule update --init
msg2 "changing branch to master..."
git submodule foreach -q --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch || echo master)'
msg2 "status.submoduleSummary = true"
git config --global status.submoduleSummary true
msg2 "submodule sync --recursive"
git submodule sync --recursive
msg2 "submodule update --init --recursive"
git submodule update --init --recursive
msg2 "pull --recurse-submodules"
git pull --recurse-submodules
msg2 "done."
