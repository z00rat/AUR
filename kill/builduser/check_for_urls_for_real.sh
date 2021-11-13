/bin/ls packages/ | xargs -n1 -I XXXXXX sh -c "pushd ~/packages/XXXXXX;pwd;echo;echo; makepkg -d --verifysource;popd;echo;echo"
