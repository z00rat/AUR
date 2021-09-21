#!/bin/bash
/usr/bin/ls repos | sort >alreadytracked.txt
msg2 "number of packags that are $(wc <alreadytracked.txt -l) tracked"

pacman -Qqm | sort >alreadyinstalled.txt
msg2 "number of packages that are $(wc <alreadyinstalled.txt -l) installed"

msg2 "packages that are not tracked but installed in the system..."
diff alreadyinstalled.txt alreadytracked.txt | grep "<" | cut -c 3-

msg2 "packages that are tracked but not installed in the system..."
diff alreadyinstalled.txt alreadytracked.txt | grep ">" | cut -c 3-

trash alreadyinstalled.txt alreadytracked.txt
msg2 "done."
