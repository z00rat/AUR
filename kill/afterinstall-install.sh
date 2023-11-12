#!/bin/bash

pacman -Syu --noconfirm
pacman -S --noconfirm base-devel git eza wget trash-cli nano highlight perl-json-xs bat man namcap tree subversion ccache pigz pbzip2 rsync bash-completion pacman-contrib
pacman -U --noconfirm /AUR/{yay-*,paru-*,trizen-*}

chown -R builduser:builduser /home/builduser/

/bin/bash -c "su builduser -s '/bin/bash'"
