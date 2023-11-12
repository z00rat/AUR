#!/bin/bash

#echo "==> rate-mirrors arch | tee mirrorlist"
#rate-mirrors arch | tee mirrorlist

echo "==> docker buildx build -t aur_tester ."
docker buildx build -t aur_tester .
