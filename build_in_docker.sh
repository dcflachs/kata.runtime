#!/bin/bash

exec docker run --rm --tmpfs /tmp -v $PWD/archive:/mnt/output:rw -e OUTPUT_FOLDER="/mnt/output" -v $PWD/source:/mnt/source:ro vbatts/slackware-base:latest /mnt/source/kata.runtime/pkg_build.sh