#!/bin/bash
for pkgname in $@ 
do
   msg2 "cloning AUR repo of '$pkgname'"

   cd repos
   git submodule add --force -b master ssh://aur@aur.archlinux.org/$pkgname.git
   git commit -m "adding $pkgname"
   cd ..

done

msg2 "done cloning"
