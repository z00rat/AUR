#!/bin/bash
# msg2 "submodule status"
# git submodule status
# echo ""
pwd=$(pwd)

msg2 "pulling update for all remote repos..."

pull_one() {
   #   cd repos/"$pkgname" || exit
   pushd repos/"$1" >/dev/null || exit

   git checkout master >/dev/null 2>/dev/null
   git pull origin master:master | grep -v "Already up to date."

   #   cd "$pwd" || exit
   popd >/dev/null || exit

   msg2 "'$1' done."
}
export -f pull_one

/usr/bin/ls repos | parallel -P 8 pull_one {}

msg2 "done cloning."
