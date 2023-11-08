#!/bin/bash
msg2 "checking for out-of-date packages"
pwd=$(pwd)
echo ""

msg2 "listing already flaged packages"
trizen -Su 2>&1 >/dev/null | grep "has been flagged" | awk '{print $2}' | tee alreadyflaged.txt

msg2 "running pkgoutofdate"
pkgoutofdate -d repos/ #--threads_num 1

msg2 "sourcing .env"
source ".env"

msg2 "running aur-out-of-date"

for pkgname in $(/usr/bin/ls repos); do
    msg2 "checking for update for '$pkgname'"

    cd repos/"$pkgname" || exit
    aur-out-of-date -local .SRCINFO #| grep "OUT-OF-DATE"
    cd "$pwd" || exit
done

msg2 "done."
