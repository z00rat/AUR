#!/bin/bash

echo "# aur link of packages that i am tracking..." >currently_tracking.md

{
    echo "---"
    /bin/ls repos | xargs -I XXXXXX echo ' - https://aur.archlinux.org/packages/XXXXXX'
    echo "---"
    echo ""
    echo "number of packages = $(/bin/ls repos | wc -l)."
    echo ""
} >>currently_tracking.md

msg2 "done."
