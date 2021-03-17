#!/bin/bash
msg2 "checking for out-of-date packages"
pwd=$(pwd)
echo ""

msg2 "running pkgoutofdate"
pkgoutofdate --threads_num 1 -v -d repos/

msg2 "running aur-out-of-date"
for pkgname in $(/usr/bin/ls repos)
do
    msg2 "checking for update for '$pkgname'"

    cd repos/$pkgname
    aur-out-of-date -local .SRCINFO
    cd $pwd

done
