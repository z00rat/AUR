#!/bin/bash
msg2 "number of inputed args is $#"
pwd=$(pwd)
let i=0

for pkgname in $@ 
do
   let i+=1
   msg2 "[$i/$#] updating .SRCINFO of '$pkgname'"
   
   cd $1
   makepkg --printsrcinfo > .SRCINFO
   cd $pwd
done

msg2 "done updating .SRCINFO file(s)"
