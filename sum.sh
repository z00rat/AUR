#!/bin/bash
msg2 "generating sum for $1"
echo ""
pwd=$(pwd)

for pkgname in $(/usr/bin/ls $1)
do
    msg2 "checksum for '$pkgname' repo"

    cd $1/$pkgname

    for file in $(tree -fia | grep -E "./")
    do
        b2sum $file #| grep -vE "b2sum:"
    done

    cd $pwd

done

msg2 "done hashing."