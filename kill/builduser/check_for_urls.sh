/bin/ls packages/ | xargs -n1 -I XXXXXX sh -c "pushd ~/packages/XXXXXX;pwd;echo;echo; MAKEPKG_CONF=/home/builduser/makepkg.user.conf makepkg -dcL --skipinteg --verifysource;popd;echo;echo"
