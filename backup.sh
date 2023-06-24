#!/bin/bash
msg2 "copying eveything from repos to pkgs"
cp -vr repos/* pkgs

for gitfile in $(tree -fia pkgs | grep -E "\.git$"); do
    msg2 "deleting '$gitfile'"
    rm "$gitfile"
done

git add pkgs

msg2 "status:"
git status

# msg2 "file tree:"
# tree -fia pkgs

msg2 "commting changes in 10s (CTRL+C to exit)"
sleep 10

msg2 "commit msg: \"$(date)\""
git commit -a -s -m "$(date)"
git push

msg2 "done."
