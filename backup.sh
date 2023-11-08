#!/bin/bash
msg2 "copying eveything from ./repos to ./pkgs"
rm -rv pkg/
cp -vr repos/* pkgs

msg2 "deleting .git files"
tree -fia pkgs | grep -E "\.git$" | parallel -P 16 rm -v {}
#for gitfile in $(tree -fia pkgs | grep -E "\.git$"); do
#    rm -v "$gitfile"
#done

msg2 "adding ./pkgs"
git add pkgs

msg2 "git status:"
git status

# msg2 "file tree:"
# tree -fia pkgs

msg2 "commting changes in 10s (CTRL+C to exit)"
sleep 10

msg2 "commit msg: \"$(date +%F--%X)\""
git commit -a -s -m "$(date +%F--%X)"
msg2 "pushing new commit"
git push

msg2 "done."
