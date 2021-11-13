#!/bin/bash
/usr/bin/duf --only local,loops -output filesystem,type,mountpoint,size,used,avail,usage,inodes_usage,inodes -theme dark -style unicode -sort mountpoint

echo ""
echo "docker run -it aur_tester"
echo ""

docker run -v "$(pwd)"/var-cache-pacman-pkg:/var/cache/pacman/pkg/ -v "$(pwd)"/aur-gits/:/home/builduser/aur-gits/ -v "$(pwd)"/pre-build-aur-pkgs/:/AUR/ -it --rm aur_tester

