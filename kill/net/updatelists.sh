#!/bin/bash
echo "[" > corepkgs.json
# pacman -Sl | awk '{print $2}' | xargs -n1 -I XXXXXX echo -e "\"XXXXXX\"," >> temp
pacman -Si | grep -i "Name            : " | awk '{print $3}' | sort -u | xargs -I XXXXXX echo -e "\"XXXXXX\"," >> temp
pacman -Si | grep -i "Provides        : " | awk '{print $3}' | sort -u | xargs -I XXXXXX echo -e "\"XXXXXX\"," >> temp
pacman -Si | grep -i "Replaces        : " | awk '{print $3}' | sort -u | xargs -I XXXXXX echo -e "\"XXXXXX\"," >> temp
sed '$ s/.$//' temp >> corepkgs.json
rm temp
echo "]" >> corepkgs.json
