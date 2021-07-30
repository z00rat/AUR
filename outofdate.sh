#!/bin/bash
msg2 "checking for out-of-date packages"
pwd=$(pwd)
#let i=0
(( i=0 ))
echo ""

msg2 "listing already flaged packages" 
trizen -Su 2>&1 >/dev/null | grep "has been flagged" | awk '{print $2}' | tee alreadyflaged.txt

msg2 "running pkgoutofdate"
pkgoutofdate -d repos/ #--threads_num 1

msg2 "running aur-out-of-date"
repolist=$(/usr/bin/ls repos)
reponum=$(/usr/bin/ls repos | wc -l)

for pkgname in $repolist
do
    #let i+=1
    (( i+=1 ))
    # msg2 "[$i/$reponum] checking for update for '$pkgname'"
    msg2 "checking for update for '$pkgname'"

    cd repos/"$pkgname" || exit
    aur-out-of-date -local .SRCINFO #| grep "OUT-OF-DATE"
    cd "$pwd" || exit
done

msg2 "done."
