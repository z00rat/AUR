### folder info:
###
- **packages/** for all the AUR git repos
- **webpage/** for download the AUR page about a package
- **something.names** would contain package names per line
### when to run which script:

#### clean up after test a list
```sh
./clean.sh
```

#### download webpages of a list of package
```sh
./download_webpage.sh something
```

#### to generate something.names from a AUR search result's wgeted html file
```sh
./parse.sh something
```

#### download all packages you want to test
```sh
./gpull.sh something
```

#### `man git-gc` all packages inside **packages/**
```sh
./gc.sh
```

#### generate a **report.md** from a ./packages/ using **dummy_report.txt**
```sh
./reportgen.sh
```