#!/bin/bash
msg2 "copying eveything from repos to pkgs"
cp -r repos/* pkgs

for gitfile in $(tree -fia pkgs | grep -E "\.git$"); do
    msg2 "deleting '$gitfile'"
    rm "$gitfile"
done

msg2 "status:"
git status

# msg2 "file tree:"
# tree -fia pkgs

msg2 "commting changes in 10s (CTRL+C to exit)"
sleep 10
echo "commit msg: \"$(date)\""
git commit -a -s -m "$(date)"
git push

msg2 "done."
