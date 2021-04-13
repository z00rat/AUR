#!/bin/bash
msg2 "list of packages that are already tracked "
/usr/bin/ls repos | sort > alreadytracked.txt
msg2 "number of packags that are $(cat alreadytracked.txt | wc -l) tracked"

msg2 "new packages "
pacman -Qqm | sort > alreadyinstalled.txt
msg2 "number of packages that are $(cat alreadyinstalled.txt | wc -l) installed"

./add.sh $(diff alreadyinstalled.txt alreadytracked.txt | grep "<" | cut -c 3-)

trash alreadyinstalled.txt alreadytracked.txt

msg2 "done."
