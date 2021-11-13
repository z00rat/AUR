< subject.html G -Eo "href=\"/packages/.+?(\")" G -Ev "href=\"/packages/\?" | cut -c 7- | rev | cut -c 2- | rev | sed '1d' > subject.urls



< subject.urls | cut -c 11- | rev | cut -c 2- | rev > subject.names



< subject.names | xargs -n 1 -I XXXXX sh -c 'git clone https://aur.archlinux.org/XXXXX.git ./packages/XXXXX && sleep 2'


/bin/ls packages/ > names



MAKEPKG_CONF="/home/builduser/makepkg.user.conf" makepkg -dc --verifysource



< subject.html | grep -Eo "href=\"/packages/.+?(\")" | grep -Ev "href=\"/packages/\?" | cut -c 17- | rev | cut -c 3- | rev | sed '1d'

.
