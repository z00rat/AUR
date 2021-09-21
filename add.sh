#!/bin/bash
for pkgname in "$@"; do
   msg2 "cloning AUR repo of '$pkgname'"

   cd repos || exit
   git submodule add --force -b master ssh://aur@aur.archlinux.org/"$pkgname".git
   git commit -s -m "adding $pkgname"
   tree -fia "$pkgname"
   cd .. || exit

done

msg2 "done cloning (if there was any)"
