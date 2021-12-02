#!/bin/bash
wget https://aur.archlinux.org/packages-meta-ext-v1.json.gz
zcat packages-meta-ext-v1.json.gz > packages-meta-ext-v1.json
rm packages-meta-ext-v1.json.gz
