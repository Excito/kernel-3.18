#!/bin/bash

cd $1

UIMLEN=$(stat --printf="%s" uImage)
UBOOTLOAD=$(( 0x00400000 ))
KERNLENLOC=$(( 0x00700000 ))
PADDINGBYTES=$(( KERNLENLOC -  ( UBOOTLOAD + UIMLEN ) ))
KERNELLEN=$(stat --printf="%s" vmlinux.bin)
dd if=/dev/zero bs="${PADDINGBYTES}" count=1 status=none >> uImage
perl -e "print pack('N',${KERNELLEN})" >> uImage
cat vmlinux.bin >> uImage
