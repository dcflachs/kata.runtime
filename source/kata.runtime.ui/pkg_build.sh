#!/bin/bash
[ -z "$OUTPUT_FOLDER" ] && echo "Output Folder not set" && exit 1
tmpdir=/tmp/tmp.$(( $RANDOM * 19318203981230 + 40 ))
version=$(date +"%Y.%m.%d")$1

mkdir -p $tmpdir/usr/local/emhttp/plugins/kata.runtime

cp -RT /mnt/source/kata.runtime/ $tmpdir/usr/local/emhttp/plugins/kata.runtime/

cd $tmpdir

chmod -R +x $tmpdir/usr/local/emhttp/plugins/kata.runtime/scripts/

makepkg -l y -c y $OUTPUT_FOLDER/kata.runtime.ui-${version}-x86_64.txz

cd /

rm -rf $tmpdir

echo "MD5:"

md5sum $OUTPUT_FOLDER/kata.runtime.ui-${version}-x86_64.txz
