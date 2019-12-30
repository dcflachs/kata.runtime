#!/bin/bash

exec docker run --rm --tmpfs /tmp -v ./archive:/mnt/output:rw -e OUTPUT_FOLDER="/mnt/output" -v ./source:/mnt/source:ro TODO_IMAGE_NAME /mnt/output/pkg_build.sh