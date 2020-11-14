#!/bin/bash

if getopts "u" arg; then
docker run --rm --tmpfs /tmp -v $PWD/archive:/mnt/output:rw -e OUTPUT_FOLDER="/mnt/output" -e KATA_VERSION -v $PWD/source/kata.runtime.ui:/mnt/source:ro vbatts/slackware:latest /mnt/source/pkg_build.sh
else
docker run --rm --tmpfs /tmp -v $PWD/archive:/mnt/output:rw -e OUTPUT_FOLDER="/mnt/output" -e KATA_VERSION -v $PWD/source/kata.runtime:/mnt/source:ro vbatts/slackware:latest /mnt/source/pkg_build.sh $UI_VERSION_LETTER
fi