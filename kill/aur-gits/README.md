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
./download_webpage.sh something.names
```

#### `man git-gc` all packages inside **packages/**
```sh
./gc.sh
```

#### download all packages you want to test
```sh
./gpull.sh something.names
```

#### to generate something.names from a AUR search result's wgeted html file
```sh
./parse.sh something
```

#### generate a **report.md** from a list using **dummy_report.txt**
```sh
./reportgen.sh something.names
```