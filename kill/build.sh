#!/bin/bash

#echo "==> rate-mirrors arch | tee mirrorlist"
#rate-mirrors arch | tee mirrorlist

echo "==> docker build -t aur_tester ."
docker build -t aur_tester .
