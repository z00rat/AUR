#!/bin/bash
/bin/ls "$1" | xargs -I XXXXXX sh -c "printf '# XXXXXX\n\n' >> report.md && cat dummy_report.txt >> report.md"
