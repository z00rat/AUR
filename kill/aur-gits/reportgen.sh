#!/bin/bash
/bin/ls ./packages/ | xargs -I XXXXXX sh -c "printf '# XXXXXX\n\n' >> report.md && cat dummy_report.txt >> report.md"
