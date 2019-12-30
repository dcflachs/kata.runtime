#!/bin/bash
[ -z "$OUTPUT_FOLDER" ] && echo "Output Folder not set" && exit 1
tmpdir=/tmp/tmp.$(( $RANDOM * 19318203981230 + 40 ))
KATA_VERSION="${KATA_VERSION:-1.9.3}"
KATA_RELEASE_TAR=kata-static-$KATA_VERSION-x86_64.tar.xz

mkdir -p $tmpdir

cd $tmpdir

wget https://github.com/kata-containers/runtime/releases/download/$KATA_VERSION/$KATA_RELEASE_TAR

tar xzvf $KATA_RELEASE_TAR

#makepkg -l y -c y ${archive}/${plugin}-${version}-x86_64-1.txz
rm -rf $tmpdir