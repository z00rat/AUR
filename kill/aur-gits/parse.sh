#!/bin/bash
< "$1" grep -Eo "href=\"/packages/.+?(\")" | grep -Ev "href=\"/packages/\?" | cut -c 17- | rev | cut -c 3- | rev | sed '1d' > "$1".names
