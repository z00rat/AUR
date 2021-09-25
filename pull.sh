#!/bin/bash
msg2 "submodule status"
git submodule status
echo ""
pwd=$(pwd)

for pkgname in $(/usr/bin/ls repos); do
   msg2 "pulling update for '$pkgname' repo"

#   cd repos/"$pkgname" || exit
   pushd repos/"$pkgname" >/dev/null
   git pull | grep -v "Already up to date."
#   cd "$pwd" || exit
   popd >/dev/null

done

msg2 "done cloning."
