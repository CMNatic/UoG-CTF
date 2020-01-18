#!/usr/bin/env bash

ARGS=$1

cd /etc

grep --quiet $ARGS= CONFIG.sh || (echo "Error parsing ARGS from config.sh" >&2 && exit 2)

source CONFIG.sh

echo ${!ARGS}
