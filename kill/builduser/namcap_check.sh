/bin/ls packages/ | xargs -n1 -I XXXXXX sh -c "echo '~/packages/XXXXXX/PKGBUILD';echo; namcap ~/packages/XXXXXX/PKGBUILD;echo;echo"
