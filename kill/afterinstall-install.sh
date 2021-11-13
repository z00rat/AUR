#!/bin/bash

pacman -Syu --noconfirm
pacman -S --noconfirm base-devel git lsd wget trash-cli nano highlight perl-json-xs bat man namcap tree subversion
pacman -U --noconfirm /AUR/{yay-*,paru-*,trizen-*}

chown -R builduser:builduser /home/builduser/

/bin/bash -c "su builduser -s '/bin/bash'"
