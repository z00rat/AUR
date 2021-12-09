#!/bin/bash
echo "[" > corepkgs.json
# pacman -Sl | awk '{print $2}' | xargs -n1 -I XXXXXX echo -e "\"XXXXXX\"," >> temp
pacman -Si | grep -i "Name            : " | cut -c 19- | tr ' ' '\n' | sort -u | xargs -I XXXXXX echo -e "\"XXXXXX\"," >> temp
pacman -Si | grep -i "Provides        : " | cut -c 19- | tr ' ' '\n' | sort -u | xargs -I XXXXXX echo -e "\"XXXXXX\"," >> temp
pacman -Si | grep -i "Replaces        : " | cut -c 19- | tr ' ' '\n' | sort -u | xargs -I XXXXXX echo -e "\"XXXXXX\"," >> temp
sed '$ s/.$//' temp >> corepkgs.json
rm temp
echo "]" >> corepkgs.json
