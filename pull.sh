#!/bin/bash
msg2 "submodule status"
msg2 $(git submodule status)
echo ""
pwd=$(pwd)

for pkgname in $(/usr/bin/ls repos)
do
   msg2 "pulling update for '$pkgname' repo"

   cd repos/$pkgname
   git pull
   cd $pwd

done

msg2 "done cloning"
