#!/bin/bash
# https://stackoverflow.com/a/55938260

for pkgname in "$@"; do
   msg2 "starting to remove submodule '$pkgname'..."

   msg2 "deiniting '$pkgname'..."
   git submodule deinit -f repos/"$pkgname"

   msg2 "deleting '.git/modules/repos/$pkgname'..."
   rm -rf .git/modules/repos/"$pkgname"

   msg2 "removing the submodule directory 'repos/$pkgname'..."
   git rm -f repos/"$pkgname"

   msg2 "committing changes..."
   git commit -s -m "removing $pkgname"

   echo ""
   echo ""
done

msg2 "done removing."
