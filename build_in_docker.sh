#!/bin/bash

docker run --rm --tmpfs /tmp -v $PWD/archive:/mnt/output:rw -e OUTPUT_FOLDER="/mnt/output" -v $PWD/source/kata.runtime:/mnt/source:ro vbatts/slackware-base:latest /mnt/source/pkg_build.sh &&
docker run --rm --tmpfs /tmp -v $PWD/archive:/mnt/output:rw -e OUTPUT_FOLDER="/mnt/output" -v $PWD/source/kata.runtime.ui:/mnt/source:ro vbatts/slackware-base:latest /mnt/source/pkg_build.sh