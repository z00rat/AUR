# AUR

In here all AUR packages that are either I **use** or I **maintain** or I **like** that project ....

## about:

#### need: trizen, pkgoutofdate, aur-out-of-date, msg2, tree, parallel

#### run: `cp ./trizen.conf ~/.config/trizen/trizen.conf`

#### add a `.env` file with
```bash
export GITHUB_TOKEN=github_pat_<...>
```

### folder info:

- **repos/** folder contains all the AUR packages git repo as submodule
- **pkgs/** folder is a copy of **repos/**
- **kill/** folder contains script and things to check if a package in AUR should be alive or not

### when to run which script:

#### run this after cloning the repo

```sh
./aftercloneing.sh
```

#### add AUR ssh key password

```sh
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/aur
```

#### check if any package you installed but not tracking

```sh
./status.sh | tee status.md
```

#### start tracking packages

```sh
./add.sh nodejs-npm2arch readability-cli
```

#### stop tracking packages

```sh
./re.sh direnv
```

#### git diff with beauty

```sh
git diff . | delta --side-by-side
```

#### pull update of all

```sh
./pull.sh
```

#### check for out-of-date packages

```sh
./outofdate.sh | tee outofdate.txt
```

##### make sure trizen will not gonna get stuck

##### flag packages or update your packages

#### make list of packages you are tracking

```sh
./currently_tracking.sh
```

#### backup everything tracked

```sh
./backup.sh
```
