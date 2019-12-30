#!/bin/bash
[ -z "$OUTPUT_FOLDER" ] && echo "Output Folder not set" && exit 1
tmpdir=/tmp/tmp.$(( $RANDOM * 19318203981230 + 40 ))


mkdir -p $tmpdir

cd $tmpdir
#makepkg -l y -c y ${archive}/${plugin}-${version}-x86_64-1.txz
rm -rf $tmpdir