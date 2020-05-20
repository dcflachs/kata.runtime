#!/bin/bash
[ -z "$OUTPUT_FOLDER" ] && echo "Output Folder not set" && exit 1
tmpdir=/tmp/tmp.$(( $RANDOM * 19318203981230 + 40 ))
KATA_VERSION="${KATA_VERSION:-1.10.1}"
KATA_RELEASE_TAR=kata-static-$KATA_VERSION-x86_64.tar.xz

mkdir -p $tmpdir

cd $tmpdir

wget --no-check-certificate https://github.com/kata-containers/runtime/releases/download/$KATA_VERSION/$KATA_RELEASE_TAR

tar xvf $KATA_RELEASE_TAR

mkdir -p $tmpdir/etc/kata-containers

#cp ./opt/kata/share/defaults/kata-containers/configuration.toml ./etc/kata-containers

sed -i 's/internetworking_model="tcfilter"/internetworking_model="macvtap"/' ./opt/kata/share/defaults/kata-containers/configuration-qemu.toml

mkdir -p $tmpdir/usr/local/emhttp/plugins/kata.runtime

cp /mnt/source/README.md ./usr/local/emhttp/plugins/kata.runtime

rm $KATA_RELEASE_TAR

makepkg -l y -c y $OUTPUT_FOLDER/kata.runtime-$KATA_VERSION-x86_64.txz

cd /

rm -rf $tmpdir

echo "MD5:"

md5sum $OUTPUT_FOLDER/kata.runtime-$KATA_VERSION-x86_64.txz
