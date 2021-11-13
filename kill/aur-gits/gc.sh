#!/bin/bash
/bin/ls packages | xargs -I XXXXXX sh -c "/usr/bin/git --git-dir=packages/XXXXXX/.git --work-tree=packages/XXXXXX gc --aggressive"
