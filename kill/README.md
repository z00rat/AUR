### folder info:
###
- **aur-gits/** parse and download AUR git repos you want ot test
- make sure **var-cache-pacman-pkg/** folder exists
- **builduser/** contains file will be needed inside the container 
- **pre-build-aur-pkgs/** should contain files 
```
paru-bin-1.9.0-1-x86_64.pkg.tar
trizen-1:1.64-1-any.pkg.tar.zst
yay-bin-11.0.2-1-x86_64.pkg.tar
```

### when to run which script:

#### build docker image
```sh
./build.sh
```

#### start a container
```sh
./spawn.sh
```
